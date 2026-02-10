//
//  AudioSessionService.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import AVFoundation

/// AudioSessionProtocol의 구현체
/// - AVAudioSession 싱글턴을 관리
/// - 백그라운드 녹음을 위한 세션 카테고리 설정
final class AudioSessionService: AudioSessionProtocol {

    // TODO: AVAudioSession.sharedInstance() 활용
    // - activateRecordingSession():
    //   setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker, .allowBluetooth])
    //   setActive(true)
    //
    // - activatePlaybackSession():
    //   setCategory(.playback, mode: .default)
    //   setActive(true)
    //
    // - deactivateSession():
    //   setActive(false, options: .notifyOthersOnDeactivation)
    //
    // - requestMicrophonePermission():
    //   AVAudioApplication.requestRecordPermission()
    //
    // - checkMicrophonePermission():
    //   AVAudioApplication.shared.recordPermission == .granted
    //
    // ⚠️ 백그라운드 녹음: Info.plist의 UIBackgroundModes에 "audio" 필수

    func activateRecordingSession() throws {
        // TODO: 구현
    }

    func activatePlaybackSession() throws {
        // TODO: 구현
    }

    func deactivateSession() throws {
        // TODO: 구현
    }

    func requestMicrophonePermission() async -> Bool {
        // TODO: 구현
        return false
    }

    func checkMicrophonePermission() -> Bool {
        // TODO: 구현
        return false
    }
}
