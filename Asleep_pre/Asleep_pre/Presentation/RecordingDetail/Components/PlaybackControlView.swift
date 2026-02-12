//
//  PlaybackControlView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct PlaybackControlView: View {
    // MARK: Property
    let isPlaying: Bool
    let onPlayPause: () -> Void
    let onSkipBackward: () -> Void
    let onSkipForward: () -> Void
    
    
    // MARK: Bodyd
    var body: some View {
        HStack(spacing: 40) {
            // 10초 뒤로
            Button(action: onSkipBackward) {
                Image(systemName: "gobackward.10")
                    .font(.system(size: 24))
                    .foregroundStyle(AppTheme.textSecondary)
            }
            .buttonStyle(.plain)

            // 재생/일시정지
            Button(action: onPlayPause) {
                ZStack {
                    Circle()
                        .fill(AppTheme.accent)
                        .frame(width: 64, height: 64)
                        .shadow(color: AppTheme.accent.opacity(0.4), radius: 12)

                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 24))
                        .foregroundStyle(.white)
                        .offset(x: isPlaying ? 0 : 2)
                }
            }
            .buttonStyle(.plain)

            // 10초 앞으로
            Button(action: onSkipForward) {
                Image(systemName: "goforward.10")
                    .font(.system(size: 24))
                    .foregroundStyle(AppTheme.textSecondary)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ZStack {
        AppTheme.background.ignoresSafeArea()
        VStack(spacing: 30) {
            PlaybackControlView(isPlaying: false, onPlayPause: {}, onSkipBackward: {}, onSkipForward: {})
            PlaybackControlView(isPlaying: true, onPlayPause: {}, onSkipBackward: {}, onSkipForward: {})
        }
    }
}
