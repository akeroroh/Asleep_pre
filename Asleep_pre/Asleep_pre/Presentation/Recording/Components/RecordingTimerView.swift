//
//  RecordingTimerView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingTimerView: View {
    let date: Date
    let elapsedTime: TimeInterval
    let isRecording: Bool

    @State private var isBlinking = false

    var body: some View {
        VStack(spacing: 12) {
            // 경과 시간
            HStack(spacing: 8) {
                if isRecording {
                    Circle()
                        .fill(AppTheme.recordActive)
                        .frame(width: 8, height: 8)
                        .opacity(isBlinking ? 0.2 : 1.0)
                        .shadow(color: AppTheme.recordActive.opacity(0.6), radius: 4)
                }

                Text(elapsedTime.formattedLongTime)
                    .font(.system(size: 48, weight: .ultraLight, design: .monospaced))
                    .foregroundStyle(isRecording ? AppTheme.textPrimary : AppTheme.textSecondary)
            }

            // 오늘 날짜
            Text(DateFormatter.recordingDateFormatter.string(from: date))
                .font(.system(size: 14))
                .foregroundStyle(AppTheme.textTertiary)
        }
        .onChange(of: isRecording) { _, newValue in
            if newValue {
                withAnimation(.easeInOut(duration: 0.7).repeatForever(autoreverses: true)) {
                    isBlinking = true
                }
            } else {
                withAnimation(.none) {
                    isBlinking = false
                }
            }
        }
    }
}

#Preview {
    ZStack {
        AppTheme.background.ignoresSafeArea()
        VStack(spacing: 40) {
            RecordingTimerView(date: Date(), elapsedTime: 0, isRecording: false)
            RecordingTimerView(date: Date(), elapsedTime: 4325, isRecording: true)
        }
    }
}
