//
//  RecordingListView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingListView: View {
    // MARK: Property
    @Environment(AppDependencyContainer.self) private var container
    @State private var viewModel: RecordingListViewModel?

    // 타임라인 설정
    private let totalHours: CGFloat = 24
    private let chartWidth: CGFloat = 1440   // 24시간 * 60pt/hr
    private let dateColumnWidth: CGFloat = 58
    private let rowHeight: CGFloat = 36
    private let headerHeight: CGFloat = 20

    // 시간 마커 (1시간 간격)
    private var timeMarkers: [(label: String, fraction: CGFloat)] {
        (0...23).map { hour in
            (String(format: "%02d", hour), CGFloat(hour) / totalHours)
        }
    }

    private var recordings: [Recording] {
        viewModel?.recordings ?? []
    }
    
    // MARK: Contants
    fileprivate enum RecordingListViewConstants {
        static let cardPadding: CGFloat = 16
        static let cardRadius: CGFloat = 20
        static let cardBackgroundPadding: EdgeInsets = .init(top: 40, leading: 12, bottom: 40, trailing: 12)
    }

    // MARK: Body
    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background
                    .ignoresSafeArea()

                // 글래스 카드
                cardContent
                    .padding(RecordingListViewConstants.cardPadding)
                    .background(
                        RoundedRectangle(cornerRadius: RecordingListViewConstants.cardRadius)
                            .fill(AppTheme.cardBackground)
                            .overlay(
                                RoundedRectangle(cornerRadius: RecordingListViewConstants.cardRadius)
                                    .stroke(AppTheme.cardBorder, lineWidth: 1)
                            )
                    )
                    .padding(RecordingListViewConstants.cardBackgroundPadding)
            }
            .navigationDestination(for: Recording.self) { recording in
                RecordingDetailView(recording: recording)
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = container.makeRecordingListViewModel()
            }
            viewModel?.loadRecordings()
        }
    }

    // MARK: - 카드 콘텐츠 (날짜 고정 + 차트 가로 스크롤)

    private var cardContent: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack(alignment: .top, spacing: 0) {
                // 왼쪽: 고정 날짜 컬럼
                dateColumn

                // 오른쪽: 가로 스크롤 차트 영역
                ScrollView(.horizontal, showsIndicators: true) {
                    chartArea
                }
                .scrollIndicators(.visible)
            }
        }
    }

    // MARK: - 고정 날짜 컬럼

    private var dateColumn: some View {
        VStack(spacing: 6) {
            // 헤더 높이 맞춤 스페이서
            Color.clear
                .frame(width: dateColumnWidth, height: headerHeight)

            ForEach(sortedRecordings) { recording in
                Text(DateFormatter.timelineRowFormatter.string(from: recording.createdAt))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(AppTheme.textSecondary)
                    .frame(width: dateColumnWidth, height: rowHeight, alignment: .trailing)
            }
        }
        .padding(.trailing, 8)
    }

    // MARK: - 가로 스크롤 차트 영역

    private var chartArea: some View {
        VStack(alignment: .leading, spacing: 6) {
            // 시간축 헤더
            timeAxisHeader

            // 녹음 바들
            ForEach(sortedRecordings) { recording in
                NavigationLink(value: recording) {
                    chartRow(for: recording)
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: - 시간축 헤더

    private var timeAxisHeader: some View {
        ZStack(alignment: .leading) {
            ForEach(timeMarkers, id: \.label) { marker in
                Text(marker.label)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundStyle(AppTheme.textTertiary)
                    .position(
                        x: marker.fraction * chartWidth,
                        y: headerHeight / 2
                    )
            }
        }
        .frame(width: chartWidth, height: headerHeight)
    }

    // MARK: - 차트 행 (바 + 가이드라인)

    private func chartRow(for recording: Recording) -> some View {
        let startFrac = timeFraction(for: recording.createdAt)
        let durationHours = recording.duration / 3600
        let widthFrac = CGFloat(durationHours) / totalHours
        let barX = startFrac * chartWidth
        let barW = max(widthFrac * chartWidth, 40)

        let startTimeStr = DateFormatter.timeOnlyFormatter.string(from: recording.createdAt)
        let endTime = recording.createdAt.addingTimeInterval(recording.duration)
        let endTimeStr = DateFormatter.timeOnlyFormatter.string(from: endTime)

        return ZStack(alignment: .leading) {
            // 3시간 간격 가이드라인
            ForEach([0, 3, 6, 9, 12, 15, 18, 21], id: \.self) { hour in
                let x = CGFloat(hour) / totalHours * chartWidth
                Path { path in
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: rowHeight))
                }
                .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [3, 3]))
                .foregroundStyle(AppTheme.textTertiary.opacity(0.3))
            }

            // 녹음 바
            Capsule()
                .fill(AppTheme.barGradient)
                .frame(width: barW, height: 28)
                .overlay(
                    HStack {
                        Text(startTimeStr)
                            .font(.system(size: 10, weight: .semibold))
                        Spacer()
                        if barW > 70 {
                            Text(endTimeStr)
                                .font(.system(size: 10, weight: .semibold))
                        }
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                )
                .offset(x: barX)
        }
        .frame(width: chartWidth, height: rowHeight)
    }

    // MARK: - 시간 → 위치 변환 (24시간 기준)

    private func timeFraction(for date: Date) -> CGFloat {
        let calendar = Calendar.current
        let hour = CGFloat(calendar.component(.hour, from: date))
        let minute = CGFloat(calendar.component(.minute, from: date)) / 60.0
        return (hour + minute) / totalHours
    }

    // MARK: - 정렬

    private var sortedRecordings: [Recording] {
        recordings.sorted { $0.createdAt > $1.createdAt }
    }
}

#Preview {
    RecordingListView()
        .environment(AppDependencyContainer())
}
