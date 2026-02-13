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
    
    // MARK: Constants
    fileprivate enum PlaybackControlViewConstants {
        static let spacing: CGFloat = 40
        static let playbackControlFont: Font = .system(size: 24)
        
        static let skipbackIcon: String = "gobackward.10"
        static let skipforwardIcon: String = "goforward.10"
        
        static let playCircleFrame: CGSize = .init(width: 64, height: 64)
        static let playImage: [String] = ["pause.fill", "play.fill"]
    }
    
    // MARK: Body
    var body: some View {
        HStack(spacing: PlaybackControlViewConstants.spacing) {
            // 10초 뒤로
            Button(action: onSkipBackward) {
                Image(systemName: PlaybackControlViewConstants.skipbackIcon)
                    .font(PlaybackControlViewConstants.playbackControlFont)
                    .foregroundStyle(AppTheme.textSecondary)
            }
            .buttonStyle(.plain)

            // 재생/일시정지
            Button(action: onPlayPause) {
                ZStack {
                    Circle()
                        .fill(AppTheme.accent)
                        .frame(width: PlaybackControlViewConstants.playCircleFrame.width, height: PlaybackControlViewConstants.playCircleFrame.height)
                        .shadow(color: AppTheme.accent.opacity(0.4), radius: 12)

                    Image(systemName: isPlaying ? PlaybackControlViewConstants.playImage[0] : PlaybackControlViewConstants.playImage[1])
                        .font(PlaybackControlViewConstants.playbackControlFont)
                        .foregroundStyle(.white)
                        .offset(x: isPlaying ? 0 : 2)
                }
            }
            .buttonStyle(.plain)

            // 10초 앞으로
            Button(action: onSkipForward) {
                Image(systemName: PlaybackControlViewConstants.skipforwardIcon)
                    .font(PlaybackControlViewConstants.playbackControlFont)
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
