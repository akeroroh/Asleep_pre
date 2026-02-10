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
final class AppDependencyContainer {

    // TODO: 싱글 인스턴스 (앱 라이프사이클에 1개)
    //
    // ──── Infra 레이어 인스턴스 ────
    // let audioSession: AudioSessionProtocol = AudioSessionService()
    // let recorder: AudioRecorderProtocol = AudioRecorderService()
    // let player: AudioPlayerProtocol = AudioPlayerService()
    // let fileManager = RecordingFileManager()
    // let repository: RecordingRepositoryProtocol = RecordingRepository(fileManager:)
    //
    // ──── ViewModel 팩토리 ────
    //
    // func makeRecordingViewModel() -> RecordingViewModel {
    //     RecordingViewModel(
    //         audioSession: audioSession,
    //         recorder: recorder,
    //         repository: repository
    //     )
    // }
    //
    // func makeRecordingListViewModel() -> RecordingListViewModel {
    //     RecordingListViewModel(repository: repository)
    // }
    //
    // func makeRecordingDetailViewModel(recording: Recording) -> RecordingDetailViewModel {
    //     RecordingDetailViewModel(
    //         player: player,
    //         audioSession: audioSession,
    //         recording: recording
    //     )
    // }
    //
    // ⚠️ Asleep_preApp.swift에서:
    //   @State private var container = AppDependencyContainer()
    //   .environment(container)
}
