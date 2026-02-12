//
//  PlaybackSliderView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct PlaybackSliderView: View {
    // MARK: Property
    @Binding var value: Double
    let duration: TimeInterval
    let onSeek: (Double) -> Void

    @State private var isDragging = false

    private var currentTimeText: String {
        (value * duration).formattedLongTime
    }

    private var durationText: String {
        duration.formattedLongTime
    }
    
    // MARK: Constants
    fileprivate enum PlaybackSliderViewConstants {
        static let stackSpacing: CGFloat = 6
        
        static let currentTimeFont: Font = .system(size: 12, design: .monospaced)
        static let durationTextFont: Font = .system(size: 12, design: .monospaced)
    }
    
    // MARK: Body
    var body: some View {
        VStack(spacing: PlaybackSliderViewConstants.stackSpacing) {
            Slider(value: $value, in: 0...1) { editing in
                isDragging = editing
                if !editing {
                    onSeek(value)
                }
            }
            .tint(AppTheme.accent)

            HStack {
                Text(currentTimeText)
                    .font(PlaybackSliderViewConstants.currentTimeFont)
                    .foregroundStyle(AppTheme.textSecondary)
                Spacer()
                Text(durationText)
                    .font(PlaybackSliderViewConstants.durationTextFont)
                    .foregroundStyle(AppTheme.textSecondary)
            }
        }
    }
}

#Preview {
    ZStack {
        AppTheme.background.ignoresSafeArea()
        PlaybackSliderView(
            value: .constant(0.35),
            duration: 7200,
            onSeek: { _ in }
        )
        .padding()
    }
}
