//
//  RecordButton.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordButton: View {
    let isRecording: Bool
    let onTap: () -> Void

    @State private var isPulsing = false
    @State private var glowOpacity: CGFloat = 0.4
    
    // MARK: Constants
    fileprivate enum RecordButtonContants {
        static let backgroundOpacity: Double = 0.15
        static let backgroundFrame: CGSize = .init(width: 140, height: 140)
        static let backgroundBlur: CGFloat = 20
        
        static let outerRingOpacity: Double = 0.3
        static let outerRingWidth: CGFloat = 3
        static let outerRingFrame: CGSize = .init(width: 100, height: 100)
        
        static let isRecordingRingOpacity: Double = 0.4
        static let isRecordingRingWidth: CGFloat = 2
        static let isRecordingRingFrame: CGSize = .init(width: 120, height: 120)
        
        static let isRecordingIconRadius: CGFloat = 8
        static let isRecordingIconFrame: CGSize = .init(width: 32, height: 32)
        
        static let isRecordingFalseIconFrame: CGSize = .init(width: 72, height: 72)
    }

    private var buttonColor: Color {
        isRecording ? AppTheme.recordActive : AppTheme.accent
    }

    // MARK: Body
    var body: some View {
        Button(action: onTap) {
            ZStack {
                // 글로우 배경
                Circle()
                    .fill(buttonColor.opacity(RecordButtonContants.backgroundOpacity))
                    .frame(width: RecordButtonContants.backgroundFrame.width, height: RecordButtonContants.backgroundFrame.height)
                    .blur(radius: RecordButtonContants.backgroundBlur)

                // 외곽 링
                Circle()
                    .stroke(buttonColor.opacity(RecordButtonContants.outerRingOpacity), lineWidth: RecordButtonContants.outerRingWidth)
                    .frame(width: RecordButtonContants.outerRingFrame.width, height: RecordButtonContants.outerRingFrame.height)

                // 녹음 중 pulse 링
                if isRecording {
                    Circle()
                        .stroke(AppTheme.recordActive.opacity(RecordButtonContants.isRecordingRingOpacity), lineWidth: RecordButtonContants.isRecordingRingWidth)
                        .frame(width: RecordButtonContants.isRecordingRingFrame.width, height: RecordButtonContants.isRecordingRingFrame.height)
                        .scaleEffect(isPulsing ? 1.3 : 1.0)
                        .opacity(isPulsing ? 0.0 : 0.6)
                }

                // 내부 아이콘
                if isRecording {
                    RoundedRectangle(cornerRadius: RecordButtonContants.isRecordingIconRadius)
                        .fill(AppTheme.recordActive)
                        .frame(width: RecordButtonContants.isRecordingIconFrame.width, height: RecordButtonContants.isRecordingIconFrame.height)
                        .shadow(color: AppTheme.recordActive.opacity(0.5), radius: 10)
                } else {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [AppTheme.accent, AppTheme.accentLight],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: RecordButtonContants.isRecordingFalseIconFrame.width, height: RecordButtonContants.isRecordingFalseIconFrame.height)
                        .shadow(color: AppTheme.accent.opacity(0.4), radius: 12)
                        .overlay(
                            Image(systemName: "mic.fill")
                                .font(.system(size: 28))
                                .foregroundStyle(.white)
                        )
                }
            }
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.25), value: isRecording)
        .onChange(of: isRecording) { _, newValue in
            if newValue {
                withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: false)) {
                    isPulsing = true
                }
            } else {
                isPulsing = false
            }
        }
    }
}

#Preview {
    ZStack {
        AppTheme.background.ignoresSafeArea()
        VStack(spacing: 60) {
            RecordButton(isRecording: false, onTap: {})
            RecordButton(isRecording: true, onTap: {})
        }
    }
}
