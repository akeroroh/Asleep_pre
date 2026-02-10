//
//  RecordingViewModel.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation
import Combine

/// 녹음 화면의 비즈니스 로직
/// - AudioRecorderProtocol, AudioSessionProtocol, RecordingRepositoryProtocol에 의존
/// - @Observable 매크로 사용 (iOS 17+)
@Observable
final class RecordingViewModel {

    // TODO: 의존성 주입
    // - private let audioSession: AudioSessionProtocol
    // - private let recorder: AudioRecorderProtocol
    // - private let repository: RecordingRepositoryProtocol
    // - private var cancellables = Set<AnyCancellable>()

    // TODO: 상태 프로퍼티
    // - var recordingState: RecordingState = .idle
    // - var selectedQuality: AudioQuality = .high
    // - var elapsedTime: TimeInterval = 0
    // - var currentDecibel: Float = 0
    // - var liveMeteringLevels: [MeteringLevel] = []  ← 실시간 파형 데이터
    // - var showPermissionAlert: Bool = false
    // - var errorMessage: String?

    // TODO: 메서드
    //
    // 1. initialize()
    //    - audioSession.requestMicrophonePermission()
    //    - 권한 거부 시 showPermissionAlert = true
    //    - recorder.statePublisher 구독 → recordingState 업데이트
    //    - recorder.meteringPublisher 구독 → liveMeteringLevels에 append
    //
    // 2. toggleRecording()
    //    - idle/ready → startRecording()
    //    - recording → stopRecording()
    //    - paused → resumeRecording()
    //
    // 3. startRecording()
    //    - audioSession.activateRecordingSession()
    //    - let fileURL = repository.generateNewFileURL()
    //    - recorder.startRecording(quality: selectedQuality, to: fileURL)
    //    - liveMeteringLevels 초기화
    //
    // 4. stopRecording()
    //    - let duration = recorder.stopRecording()
    //    - Recording 모델 생성 (meteringLevels 포함)
    //    - repository.save(recording)
    //    - audioSession.deactivateSession()
    //    - elapsedTime = 0
    //
    // 5. pauseRecording()
    //    - recorder.pauseRecording()
    //
    // 6. resumeRecording()
    //    - recorder.resumeRecording()
    //
    // 7. updateQuality(_ quality: AudioQuality)
    //    - ⚠️ 녹음 중에는 변경 불가 (recordingState == .idle일 때만)
}
