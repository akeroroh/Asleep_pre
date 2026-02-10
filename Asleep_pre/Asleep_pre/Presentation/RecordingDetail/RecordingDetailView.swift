//
//  RecordingDetailView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 녹음 상세 화면 (그래프 + 재생)
/// - Figma 디자인 참고하여 파형 그래프 표시
/// - 재생 컨트롤 (재생/일시정지, 시크바)
struct RecordingDetailView: View {

    // TODO: 파라미터
    // - let recording: Recording
    // - @State private var viewModel: RecordingDetailViewModel

    var body: some View {
        // TODO: UI 구성
        //
        // VStack(spacing: 24) {
        //   // 1. 녹음 정보 헤더
        //   VStack(spacing: 8) {
        //     Text(recording.fileName)
        //       .font(.title2.bold())
        //     Text(DateFormatter.recordingDateFormatter.string(from: recording.createdAt))
        //       .font(.subheadline)
        //       .foregroundStyle(.secondary)
        //   }
        //
        //   // 2. 파형 그래프 (Swift Charts)
        //   WaveformChartView(
        //     levels: recording.meteringLevels,
        //     currentPosition: viewModel.playbackProgress
        //   )
        //   .frame(height: 200)
        //
        //   // 3. 재생 시간 표시
        //   PlaybackTimeLabel(
        //     currentTime: viewModel.currentTime,
        //     duration: viewModel.duration
        //   )
        //
        //   // 4. 재생 위치 슬라이더
        //   PlaybackSliderView(
        //     value: $viewModel.seekPosition,
        //     duration: viewModel.duration,
        //     onSeek: { viewModel.seek(to: $0) }
        //   )
        //
        //   // 5. 재생 컨트롤 버튼
        //   PlaybackControlView(
        //     isPlaying: viewModel.isPlaying,
        //     onPlayPause: { viewModel.togglePlayback() },
        //     onStop: { viewModel.stopPlayback() },
        //     onSkipBackward: { viewModel.skip(seconds: -10) },
        //     onSkipForward: { viewModel.skip(seconds: 10) }
        //   )
        // }
        // .padding()
        // .onDisappear { viewModel.stopPlayback() }

        Text("Recording Detail View")
    }
}

#Preview {
    RecordingDetailView()
}
