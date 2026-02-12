//
//  RecordingListView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingListView: View {
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

    var body: some View {
        NavigationStack {
            ZStack {
                AppTheme.background
                    .ignoresSafeArea()

                // 글래스 카드
                cardContent
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(AppTheme.cardBackground)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(AppTheme.cardBorder, lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 12)
                    .padding(.vertical, 40)
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

// MARK: - Preview 샘플 데이터

extension RecordingListView {
    static var sampleData: [Recording] {
        let calendar = Calendar.current
        let today = Date()

        func date(daysAgo: Int, hour: Int, minute: Int) -> Date {
            let day = calendar.date(byAdding: .day, value: -daysAgo, to: today)!
            return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: day)!
        }

        func levels() -> [Float] {
            (0..<300).map { _ in Float.random(in: 0.03...0.95) }
        }

        return [
            // Day 0 — 오늘: 낮 회의 + 밤 수면
            Recording(fileName: "회의 녹음", createdAt: date(daysAgo: 0, hour: 14, minute: 0),
                      duration: 1.5 * 3600, fileURL: URL(fileURLWithPath: "/tmp/1.m4a"), meteringLevels: levels()),
            Recording(fileName: "수면 녹음", createdAt: date(daysAgo: 0, hour: 23, minute: 30),
                      duration: 7 * 3600, fileURL: URL(fileURLWithPath: "/tmp/2.m4a"), meteringLevels: levels()),

            // Day 1 — 어제: 오전 강의 + 밤 수면
            Recording(fileName: "강의 녹음", createdAt: date(daysAgo: 1, hour: 10, minute: 0),
                      duration: 2 * 3600, fileURL: URL(fileURLWithPath: "/tmp/3.m4a"), meteringLevels: levels()),
            Recording(fileName: "수면 녹음", createdAt: date(daysAgo: 1, hour: 23, minute: 45),
                      duration: 6.5 * 3600, fileURL: URL(fileURLWithPath: "/tmp/4.m4a"), meteringLevels: levels()),

            // Day 2 — 오후 메모 + 밤 수면
            Recording(fileName: "메모", createdAt: date(daysAgo: 2, hour: 16, minute: 30),
                      duration: 0.5 * 3600, fileURL: URL(fileURLWithPath: "/tmp/5.m4a"), meteringLevels: levels()),
            Recording(fileName: "수면 녹음", createdAt: date(daysAgo: 2, hour: 23, minute: 15),
                      duration: 7.5 * 3600, fileURL: URL(fileURLWithPath: "/tmp/6.m4a"), meteringLevels: levels()),

            // Day 3 — 오전 통화 + 밤 수면
            Recording(fileName: "통화", createdAt: date(daysAgo: 3, hour: 9, minute: 15),
                      duration: 0.75 * 3600, fileURL: URL(fileURLWithPath: "/tmp/7.m4a"), meteringLevels: levels()),
            Recording(fileName: "수면 녹음", createdAt: date(daysAgo: 3, hour: 22, minute: 0),
                      duration: 8 * 3600, fileURL: URL(fileURLWithPath: "/tmp/8.m4a"), meteringLevels: levels()),

            // Day 4 — 낮 회의 + 밤 수면
            Recording(fileName: "회의 녹음", createdAt: date(daysAgo: 4, hour: 13, minute: 30),
                      duration: 1 * 3600, fileURL: URL(fileURLWithPath: "/tmp/9.m4a"), meteringLevels: levels()),
            Recording(fileName: "수면 녹음", createdAt: date(daysAgo: 4, hour: 23, minute: 0),
                      duration: 7 * 3600, fileURL: URL(fileURLWithPath: "/tmp/10.m4a"), meteringLevels: levels()),

            // Day 5 — 새벽 수면 + 저녁 녹음
            Recording(fileName: "수면 녹음", createdAt: date(daysAgo: 5, hour: 0, minute: 30),
                      duration: 6 * 3600, fileURL: URL(fileURLWithPath: "/tmp/11.m4a"), meteringLevels: levels()),
            Recording(fileName: "영어 공부", createdAt: date(daysAgo: 5, hour: 19, minute: 0),
                      duration: 1.5 * 3600, fileURL: URL(fileURLWithPath: "/tmp/12.m4a"), meteringLevels: levels()),

            // Day 6 — 수면만 (1개)
            Recording(fileName: "수면 녹음", createdAt: date(daysAgo: 6, hour: 23, minute: 15),
                      duration: 7 * 3600, fileURL: URL(fileURLWithPath: "/tmp/13.m4a"), meteringLevels: levels()),

            // Day 7 — 오전 녹음 + 밤 수면
            Recording(fileName: "아이디어 메모", createdAt: date(daysAgo: 7, hour: 8, minute: 45),
                      duration: 0.3 * 3600, fileURL: URL(fileURLWithPath: "/tmp/14.m4a"), meteringLevels: levels()),
            Recording(fileName: "수면 녹음", createdAt: date(daysAgo: 7, hour: 22, minute: 45),
                      duration: 7.5 * 3600, fileURL: URL(fileURLWithPath: "/tmp/15.m4a"), meteringLevels: levels()),
        ]
    }
}

#Preview {
    RecordingListView()
        .environment(AppDependencyContainer())
}
