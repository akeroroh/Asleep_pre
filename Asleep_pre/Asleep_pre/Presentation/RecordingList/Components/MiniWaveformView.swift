//
//  MiniWaveformView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct MiniWaveformView: View {
    let levels: [Float]
    var barColor: Color = .blue
    var barCount: Int = 50

    var body: some View {
        GeometryReader { geometry in
            let displayLevels = downsample(to: barCount)
            let barWidth = max(1, (geometry.size.width - CGFloat(displayLevels.count - 1)) / CGFloat(displayLevels.count))

            HStack(alignment: .center, spacing: 1) {
                ForEach(displayLevels.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 1)
                        .fill(barColor)
                        .frame(
                            width: barWidth,
                            height: max(2, geometry.size.height * CGFloat(displayLevels[index]))
                        )
                }
            }
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }

    private func downsample(to count: Int) -> [Float] {
        guard !levels.isEmpty else {
            return Array(repeating: 0.1, count: count)
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
    let sampleLevels: [Float] = (0..<80).map { _ in Float.random(in: 0.05...0.95) }

    MiniWaveformView(levels: sampleLevels)
        .frame(height: 40)
        .padding()
}
