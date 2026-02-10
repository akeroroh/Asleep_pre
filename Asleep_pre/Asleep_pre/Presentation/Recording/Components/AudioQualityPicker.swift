//
//  AudioQualityPicker.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 음질 선택 컴포넌트
/// - Segmented Picker 스타일
/// - 녹음 중에는 비활성화
struct AudioQualityPicker: View {

    // TODO: 파라미터
    // - @Binding var selection: AudioQuality
    // - let isDisabled: Bool

    var body: some View {
        // TODO: UI 구현
        //
        // Picker("음질", selection: $selection) {
        //   ForEach(AudioQuality.allCases) { quality in
        //     Text(quality.rawValue).tag(quality)
        //   }
        // }
        // .pickerStyle(.segmented)
        // .disabled(isDisabled)
        //
        // 선택된 음질의 상세 정보 표시:
        // Text("샘플레이트: \(selection.sampleRate)Hz")
        //   .font(.caption)
        //   .foregroundStyle(.secondary)

        Text("Audio Quality Picker")
    }
}

#Preview {
    AudioQualityPicker()
}
