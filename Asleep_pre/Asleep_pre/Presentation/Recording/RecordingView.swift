//
//  RecordingView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingView: View {
    @State private var isRecording = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var showSavedAlert = false
    @State private var savedDuration: TimeInterval = 0

    var body: some View {
        ZStack {
            // 다크 배경
            AppTheme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // 경과 시간 (버튼 위)
                RecordingTimerView(
                    date: Date(),
                    elapsedTime: elapsedTime,
                    isRecording: isRecording
                )

                Spacer()
                    .frame(height: 60)

                // 녹음 버튼 (중앙)
                RecordButton(isRecording: isRecording) {
                    toggleRecording()
                }

                Spacer()
                    .frame(height: 40)

                // 상태 텍스트
                Text(isRecording ? "녹음 중..." : "탭하여 녹음 시작")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(isRecording ? AppTheme.recordActive.opacity(0.8) : AppTheme.textTertiary)
                    .animation(.easeInOut(duration: 0.3), value: isRecording)

                Spacer()
            }
        }
        .alert("녹음 저장 완료", isPresented: $showSavedAlert) {
            Button("확인", role: .cancel) {}
        } message: {
            Text("녹음 시간: \(savedDuration.formattedLongTime)\n녹음 목록에서 확인할 수 있습니다.")
        }
    }

    private func toggleRecording() {
        if isRecording {
            // 녹음 중지
            timer?.invalidate()
            timer = nil
            savedDuration = elapsedTime
            isRecording = false

            // TODO: 실제 녹음 파일 저장 로직 연동
            showSavedAlert = true
        } else {
            // 녹음 시작
            elapsedTime = 0
            isRecording = true
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                elapsedTime += 1
            }
        }
    }
}

#Preview {
    RecordingView()
}
