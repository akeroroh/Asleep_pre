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

    private var buttonColor: Color {
        isRecording ? AppTheme.recordActive : AppTheme.accent
    }

    var body: some View {
        Button(action: onTap) {
            ZStack {
                // 글로우 배경
                Circle()
                    .fill(buttonColor.opacity(0.15))
                    .frame(width: 140, height: 140)
                    .blur(radius: 20)

                // 외곽 링
                Circle()
                    .stroke(buttonColor.opacity(0.3), lineWidth: 3)
                    .frame(width: 100, height: 100)

                // 녹음 중 pulse 링
                if isRecording {
                    Circle()
                        .stroke(AppTheme.recordActive.opacity(0.4), lineWidth: 2)
                        .frame(width: 120, height: 120)
                        .scaleEffect(isPulsing ? 1.3 : 1.0)
                        .opacity(isPulsing ? 0.0 : 0.6)
                }

                // 내부 아이콘
                if isRecording {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(AppTheme.recordActive)
                        .frame(width: 32, height: 32)
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
                        .frame(width: 72, height: 72)
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
