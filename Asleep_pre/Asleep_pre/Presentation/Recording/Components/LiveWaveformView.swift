//
//  LiveWaveformView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 실시간 녹음 중 파형 애니메이션 컴포넌트
/// - 데시벨 레벨에 따라 막대/파형이 움직임
/// - Canvas 또는 Path로 커스텀 드로잉
struct LiveWaveformView: View {

    // TODO: 파라미터
    // - let meteringLevels: [MeteringLevel]
    // - let barCount: Int = 40  ← 화면에 보여줄 막대 개수
    // - let barSpacing: CGFloat = 2
    // - let isAnimating: Bool

    var body: some View {
        // TODO: UI 구현 (2가지 방식 중 택 1)
        //
        // ──── 방식 A: HStack + RoundedRectangle ────
        // GeometryReader { geometry in
        //   HStack(alignment: .center, spacing: barSpacing) {
        //     ForEach(최근 barCount개 레벨) { level in
        //       RoundedRectangle(cornerRadius: 2)
        //         .fill(.blue)
        //         .frame(
        //           width: barWidth,
        //           height: max(2, geometry.size.height * CGFloat(level.normalizedLevel))
        //         )
        //     }
        //   }
        // }
        // .animation(.linear(duration: 0.05), value: meteringLevels.count)
        //
        // ──── 방식 B: Canvas (고성능) ────
        // Canvas { context, size in
        //   for (index, level) in levels.enumerated() {
        //     let rect = CGRect(...)
        //     context.fill(Path(roundedRect: rect, ...), with: .color(.blue))
        //   }
        // }

        Text("Live Waveform")
    }
}

#Preview {
    LiveWaveformView()
}
