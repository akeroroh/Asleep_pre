//
//  WaveformChartView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI
import Charts

/// 녹음 결과 파형 그래프 (Swift Charts)
/// - 녹음 완료 후 전체 데시벨 레벨을 시각화
/// - 현재 재생 위치를 RuleMark로 표시
struct WaveformChartView: View {

    // TODO: 파라미터
    // - let levels: [MeteringLevel]          ← 전체 미터링 데이터
    // - let currentPosition: Double          ← 재생 진행률 (0.0 ~ 1.0)
    // - var barColor: Color = .blue
    // - var positionIndicatorColor: Color = .red

    var body: some View {
        // TODO: UI 구현 (Swift Charts)
        //
        // Chart {
        //   ForEach(levels) { level in
        //     // 막대형 그래프 (BarMark)
        //     BarMark(
        //       x: .value("Time", level.time),
        //       y: .value("Level", level.normalizedLevel)
        //     )
        //     .foregroundStyle(
        //       level.time <= currentTimeFromProgress
        //         ? barColor              ← 재생된 부분
        //         : barColor.opacity(0.3) ← 아직 재생 안 된 부분
        //     )
        //     .cornerRadius(1)
        //   }
        //
        //   // 현재 재생 위치 표시선
        //   if currentPosition > 0 {
        //     RuleMark(x: .value("Position", currentTimeFromProgress))
        //       .foregroundStyle(positionIndicatorColor)
        //       .lineStyle(StrokeStyle(lineWidth: 2))
        //   }
        // }
        // .chartXAxis(.hidden)
        // .chartYAxis(.hidden)
        // .chartYScale(domain: 0...1)
        //
        // ⚠️ 데이터가 많을 경우 다운샘플링 필요
        //    - levels 배열을 화면 너비에 맞게 리샘플링

        Text("Waveform Chart")
    }
}

#Preview {
    WaveformChartView()
}
