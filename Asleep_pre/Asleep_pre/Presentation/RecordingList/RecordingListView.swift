//
//  RecordingListView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 녹음 목록 화면
/// - 저장된 녹음 파일 리스트
/// - 항목 탭 → 상세(그래프+재생) 화면 이동
/// - 스와이프 삭제
struct RecordingListView: View {

    // TODO: @State private var viewModel = RecordingListViewModel(...)

    var body: some View {
        // TODO: UI 구성
        //
        // NavigationStack {
        //   Group {
        //     if viewModel.recordings.isEmpty {
        //       ContentUnavailableView("녹음이 없습니다",
        //         systemImage: "waveform",
        //         description: Text("녹음 탭에서 새 녹음을 시작하세요"))
        //     } else {
        //       List {
        //         ForEach(viewModel.recordings) { recording in
        //           NavigationLink(value: recording) {
        //             RecordingRowView(recording: recording)
        //           }
        //         }
        //         .onDelete { indexSet in
        //           viewModel.deleteRecordings(at: indexSet)
        //         }
        //       }
        //     }
        //   }
        //   .navigationTitle("녹음 목록")
        //   .navigationDestination(for: Recording.self) { recording in
        //     RecordingDetailView(recording: recording)
        //   }
        //   .onAppear { viewModel.loadRecordings() }
        // }

        Text("Recording List View")
    }
}

#Preview {
    RecordingListView()
}
