//
//  PlaybackSliderView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 재생 위치 슬라이더 컴포넌트
/// - 드래그하여 재생 위치 변경
/// - 현재 시간 / 전체 시간 라벨 표시
struct PlaybackSliderView: View {

    // TODO: 파라미터
    // - @Binding var value: Double       ← 0.0 ~ 1.0
    // - let duration: TimeInterval
    // - let onSeek: (Double) -> Void     ← 드래그 종료 시 호출
    // - @State private var isDragging = false

    var body: some View {
        // TODO: UI 구현
        //
        // VStack(spacing: 4) {
        //   Slider(value: $value, in: 0...1) { editing in
        //     isDragging = editing
        //     if !editing {
        //       onSeek(value)
        //     }
        //   }
        //   .tint(.blue)
        //
        //   HStack {
        //     Text(currentTimeFormatted)    ← value * duration → "00:00"
        //       .font(.caption)
        //       .foregroundStyle(.secondary)
        //     Spacer()
        //     Text(durationFormatted)        ← duration → "00:00"
        //       .font(.caption)
        //       .foregroundStyle(.secondary)
        //   }
        // }
        //
        // ⚠️ isDragging 중에는 외부 업데이트를 무시해야
        //    슬라이더가 튀지 않음

        Text("Playback Slider")
    }
}

#Preview {
    PlaybackSliderView()
}
