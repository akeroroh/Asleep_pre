//
//  RecordButton.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 녹음 시작/중지 버튼 컴포넌트
/// - 상태에 따라 아이콘/색상 변경
/// - idle: 빨간 원 (녹음 시작)
/// - recording: 빨간 사각형 (녹음 중지)
/// - paused: 빨간 원 (녹음 재개)
struct RecordButton: View {

    // TODO: 파라미터
    // - let state: RecordingState
    // - let onTap: () -> Void
    // - let onLongPress: (() -> Void)?  ← 일시정지용 (선택)

    var body: some View {
        // TODO: UI 구현
        //
        // Button(action: onTap) {
        //   ZStack {
        //     Circle()
        //       .fill(.red.opacity(0.2))
        //       .frame(width: 80, height: 80)
        //
        //     switch state:
        //       case .idle, .ready, .paused:
        //         Circle().fill(.red).frame(width: 60, height: 60)
        //       case .recording:
        //         RoundedRectangle(cornerRadius: 8).fill(.red).frame(width: 32, height: 32)
        //       default: EmptyView()
        //   }
        // }
        // .animation(.easeInOut(duration: 0.2), value: state)
        // ⚠️ 녹음 중 pulse 애니메이션 추가 고려

        Text("Record Button")
    }
}

#Preview {
    RecordButton()
}
