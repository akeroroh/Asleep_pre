//
//  PlaybackControlView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 재생 컨트롤 버튼 그룹
/// - 10초 뒤로 / 재생·일시정지 / 10초 앞으로 / 정지
struct PlaybackControlView: View {

    // TODO: 파라미터
    // - let isPlaying: Bool
    // - let onPlayPause: () -> Void
    // - let onStop: () -> Void
    // - let onSkipBackward: () -> Void
    // - let onSkipForward: () -> Void

    var body: some View {
        // TODO: UI 구현
        //
        // HStack(spacing: 32) {
        //   // 10초 뒤로
        //   Button(action: onSkipBackward) {
        //     Image(systemName: "gobackward.10")
        //       .font(.title2)
        //   }
        //
        //   // 재생/일시정지
        //   Button(action: onPlayPause) {
        //     Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
        //       .font(.system(size: 56))
        //       .foregroundStyle(.blue)
        //   }
        //
        //   // 10초 앞으로
        //   Button(action: onSkipForward) {
        //     Image(systemName: "goforward.10")
        //       .font(.title2)
        //   }
        // }

        Text("Playback Controls")
    }
}

#Preview {
    PlaybackControlView()
}
