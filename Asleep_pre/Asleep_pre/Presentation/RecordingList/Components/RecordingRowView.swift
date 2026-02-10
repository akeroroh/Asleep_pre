//
//  RecordingRowView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 녹음 목록의 개별 셀 컴포넌트
/// - 파일명, 날짜, 녹음 길이 표시
/// - 미니 파형 미리보기 (선택)
struct RecordingRowView: View {

    // TODO: 파라미터
    // - let recording: Recording

    var body: some View {
        // TODO: UI 구현
        //
        // HStack(spacing: 12) {
        //   // 아이콘
        //   Image(systemName: "waveform")
        //     .foregroundStyle(.blue)
        //     .frame(width: 40, height: 40)
        //     .background(.blue.opacity(0.1))
        //     .clipShape(RoundedRectangle(cornerRadius: 8))
        //
        //   // 정보
        //   VStack(alignment: .leading, spacing: 4) {
        //     Text(recording.fileName)
        //       .font(.headline)
        //       .lineLimit(1)
        //
        //     HStack {
        //       Text(DateFormatter.recordingDateFormatter.string(from: recording.createdAt))
        //       Text("·")
        //       Text(recording.duration.formattedTime)
        //     }
        //     .font(.caption)
        //     .foregroundStyle(.secondary)
        //   }
        //
        //   Spacer()
        //
        //   Image(systemName: "chevron.right")
        //     .foregroundStyle(.tertiary)
        // }
        // .padding(.vertical, 4)

        Text("Recording Row")
    }
}

#Preview {
    RecordingRowView()
}
