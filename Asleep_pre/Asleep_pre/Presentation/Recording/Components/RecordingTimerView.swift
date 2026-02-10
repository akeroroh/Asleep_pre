//
//  RecordingTimerView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 녹음 경과 시간 표시 컴포넌트
/// - "00:00" 또는 "00:00:00" 형식
/// - 녹음 중 빨간 인디케이터 표시
struct RecordingTimerView: View {

    // TODO: 파라미터
    // - let elapsedTime: TimeInterval
    // - let isRecording: Bool

    var body: some View {
        // TODO: UI 구현
        //
        // HStack(spacing: 8) {
        //   if isRecording {
        //     Circle()
        //       .fill(.red)
        //       .frame(width: 8, height: 8)
        //       .opacity(blinkAnimation)  ← 깜빡임 애니메이션
        //   }
        //
        //   Text(elapsedTime.formattedTime)
        //     .font(.system(size: 48, weight: .light, design: .monospaced))
        //     .foregroundStyle(isRecording ? .primary : .secondary)
        // }

        Text("00:00")
    }
}

#Preview {
    RecordingTimerView()
}
