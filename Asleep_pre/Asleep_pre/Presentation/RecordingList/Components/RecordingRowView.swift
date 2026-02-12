//
//  RecordingRowView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingRowView: View {
    let recording: Recording

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 상단: 파일명 + 시간 정보
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(recording.fileName)
                        .font(.headline)
                        .lineLimit(1)

                    HStack(spacing: 6) {
                        Image(systemName: "clock")
                            .font(.caption2)
                            .foregroundStyle(.secondary)

                        Text(recording.duration.formattedTime)
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("·")
                            .foregroundStyle(.secondary)

                        Text(DateFormatter.recordingDateFormatter.string(from: recording.createdAt))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }

            // 하단: 미니 파형 그래프
            MiniWaveformView(
                levels: recording.meteringLevels,
                barColor: .blue.opacity(0.7)
            )
            .frame(height: 36)
        }
        .padding(16)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    let sample = Recording(
        fileName: "녹음 2026.02.10",
        duration: 185,
        fileURL: URL(fileURLWithPath: "/tmp/test.m4a"),
        meteringLevels: (0..<80).map { _ in Float.random(in: 0.05...0.9) }
    )

    RecordingRowView(recording: sample)
        .padding()
        .background(Color(.systemGroupedBackground))
}
