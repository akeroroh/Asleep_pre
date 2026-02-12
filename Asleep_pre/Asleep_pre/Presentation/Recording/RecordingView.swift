//
//  RecordingView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingView: View {
    @Environment(AppDependencyContainer.self) private var container
    @State private var viewModel: RecordingViewModel?

    var body: some View {
        ZStack {
            // 다크 배경
            AppTheme.background
                .ignoresSafeArea()

            if let viewModel {
                VStack(spacing: 0) {
                    Spacer()

                    // 경과 시간 (버튼 위)
                    RecordingTimerView(
                        date: Date(),
                        elapsedTime: viewModel.elapsedTime,
                        isRecording: viewModel.isRecording
                    )

                    Spacer()
                        .frame(height: 60)

                    // 녹음 버튼 (중앙)
                    RecordButton(isRecording: viewModel.isRecording) {
                        viewModel.toggleRecording()
                    }

                    Spacer()
                        .frame(height: 40)

                    // 상태 텍스트
                    Text(viewModel.isRecording ? "녹음 중..." : "탭하여 녹음 시작")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(viewModel.isRecording ? AppTheme.recordActive.opacity(0.8) : AppTheme.textTertiary)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.isRecording)

                    Spacer()
                }
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = container.makeRecordingViewModel()
                viewModel?.initialize()
            }
        }
        .alert("녹음 저장 완료", isPresented: Binding(
            get: { viewModel?.showSavedAlert ?? false },
            set: { viewModel?.showSavedAlert = $0 }
        )) {
            Button("확인", role: .cancel) {}
        } message: {
            Text("녹음 시간: \((viewModel?.savedDuration ?? 0).formattedLongTime)\n녹음 목록에서 확인할 수 있습니다.")
        }
        .alert("마이크 권한 필요", isPresented: Binding(
            get: { viewModel?.showPermissionAlert ?? false },
            set: { viewModel?.showPermissionAlert = $0 }
        )) {
            Button("설정으로 이동") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text("녹음을 위해 마이크 접근 권한이 필요합니다.\n설정에서 권한을 허용해주세요.")
        }
    }
}

#Preview {
    RecordingView()
        .environment(AppDependencyContainer())
}
