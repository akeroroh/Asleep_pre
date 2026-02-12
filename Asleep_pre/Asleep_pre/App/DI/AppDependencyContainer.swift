//
//  AppDependencyContainer.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// 앱 전역 의존성 컨테이너
/// - Protocol ↔ 구현체 바인딩
/// - ViewModel에 의존성 주입
@Observable
@MainActor
final class AppDependencyContainer {

    // MARK: - Infra 레이어 인스턴스

    let audioSession: AudioSessionProtocol = AudioSessionService()
    let recorder: AudioRecorderProtocol = AudioRecorderService()
    let player: AudioPlayerProtocol = AudioPlayerService()
    private let recordingFileManager = RecordingFileManager()
    let repository: RecordingRepositoryProtocol

    init() {
        self.repository = RecordingRepository(fileManager: recordingFileManager)
    }

    // MARK: - ViewModel 팩토리

    func makeRecordingViewModel() -> RecordingViewModel {
        RecordingViewModel(
            audioSession: audioSession,
            recorder: recorder,
            repository: repository
        )
    }

    func makeRecordingListViewModel() -> RecordingListViewModel {
        RecordingListViewModel(repository: repository)
    }

    func makeRecordingDetailViewModel(recording: Recording) -> RecordingDetailViewModel {
        RecordingDetailViewModel(
            player: player,
            audioSession: audioSession,
            recording: recording
        )
    }
}
