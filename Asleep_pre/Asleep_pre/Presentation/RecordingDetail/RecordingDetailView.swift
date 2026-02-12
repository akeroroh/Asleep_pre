//
//  RecordingDetailView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingDetailView: View {
    // MARK: Property
    @Environment(AppDependencyContainer.self) private var container
    @State private var viewModel: RecordingDetailViewModel?

    let recording: Recording

    private var startTimeStr: String {
        DateFormatter.timeOnlyFormatter.string(from: recording.createdAt)
    }

    private var endTimeStr: String {
        let endDate = recording.createdAt.addingTimeInterval(recording.duration)
        return DateFormatter.timeOnlyFormatter.string(from: endDate)
    }
    
    // MARK: Constants
    fileprivate enum RecordingDetailViewConstants {
        static let scrollViewSpacing: CGFloat = 28
        static let scrollViewPadding: EdgeInsets = .init(top: 20, leading: 16, bottom: 20, trailing: 16)
        
        static let infoCardSpacing: CGFloat = 16
        static let infoCardHStackSpacing: CGFloat = 20
        static let infoCardPadding: CGFloat = 20
        static let infoCardLabel: [String] = ["시작", "종료", "녹음 시간"]
        static let infoCardIcon: [String] = ["moon.fill", "sun.max.fill", "clock.fill"]
        
        static let timeLabelSpacing: CGFloat = 6
        static let timeLabelImageFont: Font = .system(size: 14)
        static let timeLabeltitleFont: Font = .system(size: 11)
        static let timeLabelTimeFont: Font = .system(size: 16, weight: .semibold, design: .monospaced)
        
        static let waveCardSpacing: CGFloat = 12
        static let waveCardPadding: CGFloat = 20
        static let waveCardTitle: String = "오디오 파형"
        static let waveCardTitleFont: Font = .system(size: 14, weight: .semibold)
        static let waveTimeLabelFont: Font = .system(size: 11, design: .monospaced)
        
        static let controlCardSpacing: CGFloat = 20
        static let controlCardPadding: CGFloat = 20
        
        static let glassCardRadius: CGFloat = 16
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            AppTheme.background
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: RecordingDetailViewConstants.scrollViewSpacing) {

                    // MARK: - 녹음 정보 카드
                    infoCard

                    // MARK: - 파형 그래프 카드
                    waveformCard

                    // MARK: - 재생 컨트롤 카드
                    controlCard
                }
                .padding(RecordingDetailViewConstants.scrollViewPadding)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            if viewModel == nil {
                viewModel = container.makeRecordingDetailViewModel(recording: recording)
                viewModel?.initialize()
            }
        }
        .onDisappear {
            viewModel?.stopPlayback()
        }
    }

    // MARK: - 녹음 정보

    private var infoCard: some View {
        VStack(spacing: RecordingDetailViewConstants.infoCardSpacing) {
            // 날짜
            Text(DateFormatter.sectionDateFormatter.string(from: recording.createdAt))
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)

            // 시작 ~ 종료 시간
            HStack(spacing: RecordingDetailViewConstants.infoCardHStackSpacing) {
                timeLabel(title: RecordingDetailViewConstants.infoCardLabel[0], time: startTimeStr, icon: RecordingDetailViewConstants.infoCardIcon[0])
                divider
                timeLabel(title: RecordingDetailViewConstants.infoCardLabel[1], time: endTimeStr, icon: RecordingDetailViewConstants.infoCardIcon[1])
                divider
                timeLabel(title: RecordingDetailViewConstants.infoCardLabel[2], time: recording.duration.formattedLongTime, icon: RecordingDetailViewConstants.infoCardIcon[2])
            }
        }
        .padding(RecordingDetailViewConstants.infoCardPadding)
        .frame(maxWidth: .infinity)
        .background(glassCard)
    }

    private func timeLabel(title: String, time: String, icon: String) -> some View {
        VStack(spacing: RecordingDetailViewConstants.timeLabelSpacing) {
            Image(systemName: icon)
                .font(RecordingDetailViewConstants.timeLabelImageFont)
                .foregroundStyle(AppTheme.accent)
            Text(title)
                .font(RecordingDetailViewConstants.timeLabeltitleFont)
                .foregroundStyle(AppTheme.textTertiary)
            Text(time)
                .font(RecordingDetailViewConstants.timeLabelTimeFont)
                .foregroundStyle(AppTheme.textPrimary)
        }
    }

    private var divider: some View {
        Rectangle()
            .fill(AppTheme.textTertiary)
            .frame(width: 1, height: 40)
    }

    // MARK: - 파형 그래프

    private var waveformCard: some View {
        VStack(alignment: .leading, spacing: RecordingDetailViewConstants.waveCardSpacing) {
            Text(RecordingDetailViewConstants.waveCardTitle)
                .font(RecordingDetailViewConstants.waveCardTitleFont)
                .foregroundStyle(AppTheme.textSecondary)

            WaveformChartView(
                levels: recording.meteringLevels,
                playbackProgress: viewModel?.playbackProgress ?? 0
            )
            .frame(height: 180)

            // 시간 축 라벨
            HStack {
                Text(startTimeStr)
                Spacer()
                let midTime = recording.createdAt.addingTimeInterval(recording.duration / 2)
                Text(DateFormatter.timeOnlyFormatter.string(from: midTime))
                Spacer()
                Text(endTimeStr)
            }
            .font(RecordingDetailViewConstants.waveTimeLabelFont)
            .foregroundStyle(AppTheme.textTertiary)
        }
        .padding(RecordingDetailViewConstants.waveCardPadding)
        .frame(maxWidth: .infinity)
        .background(glassCard)
    }

    // MARK: - 재생 컨트롤

    private var controlCard: some View {
        VStack(spacing: RecordingDetailViewConstants.controlCardSpacing) {
            PlaybackSliderView(
                value: Binding(
                    get: { viewModel?.seekPosition ?? 0 },
                    set: { viewModel?.seek(to: $0) }
                ),
                duration: recording.duration,
                onSeek: { position in
                    viewModel?.seek(to: position)
                }
            )

            PlaybackControlView(
                isPlaying: viewModel?.isPlaying ?? false,
                onPlayPause: {
                    viewModel?.togglePlayback()
                },
                onSkipBackward: {
                    viewModel?.skip(seconds: -10)
                },
                onSkipForward: {
                    viewModel?.skip(seconds: 10)
                }
            )
        }
        .padding(RecordingDetailViewConstants.controlCardPadding)
        .frame(maxWidth: .infinity)
        .background(glassCard)
    }

    // MARK: - 공통 카드 배경

    private var glassCard: some View {
        RoundedRectangle(cornerRadius: RecordingDetailViewConstants.glassCardRadius)
            .fill(AppTheme.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: RecordingDetailViewConstants.glassCardRadius)
                    .stroke(AppTheme.cardBorder, lineWidth: 1)
            )
    }
}

#Preview {
    NavigationStack {
        RecordingDetailView(
            recording: Recording(
                fileName: "녹음 001",
                createdAt: {
                    let cal = Calendar.current
                    return cal.date(bySettingHour: 23, minute: 30, second: 0, of: Date())!
                }(),
                duration: 7 * 3600,
                fileURL: URL(fileURLWithPath: "/tmp/test.m4a"),
                meteringLevels: (0..<300).map { _ in Float.random(in: 0.03...0.95) }
            )
        )
    }
    .environment(AppDependencyContainer())
}
