//
//  RecordingView.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

struct RecordingView: View {
    // MARK: Property
    @Environment(AppDependencyContainer.self) private var container
    @State private var viewModel: RecordingViewModel?
    
    // MARK: Constants
    fileprivate enum RecordingViewConstant {
        static let recordingViewSpacing: CGFloat = 40
        
        static let isRecordingTrueMessage: String = "녹음 중..."
        static let isRecordingFalseMessage: String = "탭하여 녹음 시작"
        
        static let recordingCompletedTitleMessage: String = "녹음 저장 완료"
        static let recordingCompleteButtonMessage: String = "확인"
        static func recordingCompleteMessage(duration: TimeInterval) -> String {
                return "녹음 시간: \(duration.formattedLongTime)\n녹음 목록에서 확인할 수 있습니다."
            }
        
        static let recordingPermissionTitleMessage: String = "마이크 권한 필요"
        static let recordingPermissionOkButtonMessgae: String = "설정으로 이동"
        static let recordingPermissionCancelButtonMessage: String = "취소"
        static let recordingPermissionMessage: String = "녹음을 위해 마이크 접근 권한이 필요합니다.\n설정에서 권한을 허용해주세요."
        
    }

    // MARK: Body
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
                        .frame(height: RecordingViewConstant.recordingViewSpacing)

                    // 녹음 버튼 (중앙)
                    RecordButton(isRecording: viewModel.isRecording) {
                        viewModel.toggleRecording()
                    }

                    Spacer()
                        .frame(height: RecordingViewConstant.recordingViewSpacing)

                    // 상태 텍스트
                    Text(viewModel.isRecording ? RecordingViewConstant.isRecordingTrueMessage : RecordingViewConstant.isRecordingFalseMessage)
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
        .alert(RecordingViewConstant.recordingCompletedTitleMessage, isPresented: Binding(
            get: { viewModel?.showSavedAlert ?? false },
            set: { viewModel?.showSavedAlert = $0 }
        )) {
            Button(RecordingViewConstant.recordingCompleteButtonMessage, role: .cancel) {}
        } message: {
            Text(RecordingViewConstant.recordingCompleteMessage(duration: viewModel?.savedDuration ?? 0))
        }
        .alert(RecordingViewConstant.recordingPermissionTitleMessage, isPresented: Binding(
            get: { viewModel?.showPermissionAlert ?? false },
            set: { viewModel?.showPermissionAlert = $0 }
        )) {
            Button(RecordingViewConstant.recordingPermissionOkButtonMessgae) {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button(RecordingViewConstant.recordingPermissionCancelButtonMessage, role: .cancel) {}
        } message: {
            Text(RecordingViewConstant.recordingPermissionMessage)
        }
    }
}

#Preview {
    RecordingView()
        .environment(AppDependencyContainer())
}
