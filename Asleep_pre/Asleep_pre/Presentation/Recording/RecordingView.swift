//
//  RecordingView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

/// 녹음 메인 화면
/// - 녹음 시작/중지/일시정지 버튼
/// - 실시간 파형 애니메이션
/// - 경과 시간 표시
/// - 음질 선택 피커
struct RecordingView: View {

    // TODO: @State private var viewModel = RecordingViewModel(...)
    //       또는 @Environment로 주입

    var body: some View {
        // TODO: UI 구성 순서
        //
        // NavigationStack {
        //   VStack {
        //     1. RecordingTimerView(elapsedTime:)
        //        - 경과 시간 "00:00" 표시
        //
        //     2. LiveWaveformView(levels:)
        //        - 실시간 데시벨 파형 애니메이션
        //
        //     3. AudioQualityPicker(selection:, disabled:)
        //        - 음질 선택 (녹음 중 비활성화)
        //
        //     4. RecordButton(state:, onTap:)
        //        - 녹음 시작/중지 토글 버튼
        //   }
        //   .navigationTitle("녹음")
        //   .onAppear { viewModel.initialize() }
        //   .alert("마이크 권한 필요", isPresented:) { 설정 이동 버튼 }
        // }

        Text("Recording View")
    }
}

#Preview {
    RecordingView()
}
