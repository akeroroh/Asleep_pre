//
//  WaveformChartView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI
import Charts

struct WaveformChartView: View {
    let levels: [Float]
    var playbackProgress: Double = 0.0
    var barCount: Int = 100

    var body: some View {
        let displayLevels = downsample(to: barCount)

        Chart {
            ForEach(Array(displayLevels.enumerated()), id: \.offset) { index, level in
                let time = Double(index)
                let progressTime = Double(displayLevels.count) * playbackProgress

                BarMark(
                    x: .value("Time", time),
                    y: .value("Level", level)
                )
                .foregroundStyle(
                    time <= progressTime
                        ? AppTheme.accent
                        : AppTheme.accent.opacity(0.3)
                )
                .cornerRadius(1)
            }

            // 재생 위치 인디케이터
            if playbackProgress > 0 && playbackProgress < 1 {
                let position = Double(displayLevels.count) * playbackProgress
                RuleMark(x: .value("Position", position))
                    .foregroundStyle(AppTheme.textPrimary)
                    .lineStyle(StrokeStyle(lineWidth: 1.5))
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartYScale(domain: 0...1)
        .chartPlotStyle { plotArea in
            plotArea
                .background(Color.clear)
        }
    }

    private func downsample(to count: Int) -> [Float] {
        guard !levels.isEmpty else {
            return Array(repeating: 0.05, count: count)
        }

        guard levels.count > count else {
            return levels
        }

        let chunkSize = levels.count / count
        return stride(from: 0, to: levels.count, by: chunkSize)
            .prefix(count)
            .map { start in
                let end = min(start + chunkSize, levels.count)
                let chunk = levels[start..<end]
                return chunk.reduce(0, +) / Float(chunk.count)
            }
    }
}

#Preview {
    let sampleLevels: [Float] = (0..<300).map { _ in Float.random(in: 0.03...0.95) }

    ZStack {
        AppTheme.background.ignoresSafeArea()
        WaveformChartView(levels: sampleLevels, playbackProgress: 0.4)
            .frame(height: 180)
            .padding()
    }
}
