//
//  RecordingDetailView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingDetailView: View {
    let recording: Recording

    // TODO: ViewModel 연동 후 교체
    @State private var isPlaying = false
    @State private var playbackProgress: Double = 0.0

    private var startTimeStr: String {
        DateFormatter.timeOnlyFormatter.string(from: recording.createdAt)
    }

    private var endTimeStr: String {
        let endDate = recording.createdAt.addingTimeInterval(recording.duration)
        return DateFormatter.timeOnlyFormatter.string(from: endDate)
    }

    var body: some View {
        ZStack {
            AppTheme.background
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 28) {

                    // MARK: - 녹음 정보 카드
                    infoCard

                    // MARK: - 파형 그래프 카드
                    waveformCard

                    // MARK: - 재생 컨트롤 카드
                    controlCard
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(AppTheme.background, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    // MARK: - 녹음 정보

    private var infoCard: some View {
        VStack(spacing: 16) {
            // 날짜
            Text(DateFormatter.sectionDateFormatter.string(from: recording.createdAt))
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(AppTheme.textPrimary)

            // 시작 ~ 종료 시간
            HStack(spacing: 20) {
                timeLabel(title: "시작", time: startTimeStr, icon: "moon.fill")
                divider
                timeLabel(title: "종료", time: endTimeStr, icon: "sun.max.fill")
                divider
                timeLabel(title: "녹음 시간", time: recording.duration.formattedLongTime, icon: "clock.fill")
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(glassCard)
    }

    private func timeLabel(title: String, time: String, icon: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(AppTheme.accent)
            Text(title)
                .font(.system(size: 11))
                .foregroundStyle(AppTheme.textTertiary)
            Text(time)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
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
        VStack(alignment: .leading, spacing: 12) {
            Text("오디오 파형")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(AppTheme.textSecondary)

            WaveformChartView(
                levels: recording.meteringLevels,
                playbackProgress: playbackProgress
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
            .font(.system(size: 11, design: .monospaced))
            .foregroundStyle(AppTheme.textTertiary)
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(glassCard)
    }

    // MARK: - 재생 컨트롤

    private var controlCard: some View {
        VStack(spacing: 20) {
            PlaybackSliderView(
                value: $playbackProgress,
                duration: recording.duration,
                onSeek: { _ in
                    // TODO: player.seek(to:) 연동
                }
            )

            PlaybackControlView(
                isPlaying: isPlaying,
                onPlayPause: {
                    isPlaying.toggle()
                    // TODO: player.play/pause 연동
                },
                onSkipBackward: {
                    playbackProgress = max(0, playbackProgress - 10.0 / recording.duration)
                    // TODO: player.seek 연동
                },
                onSkipForward: {
                    playbackProgress = min(1, playbackProgress + 10.0 / recording.duration)
                    // TODO: player.seek 연동
                }
            )
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(glassCard)
    }

    // MARK: - 공통 카드 배경

    private var glassCard: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(AppTheme.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
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
}
