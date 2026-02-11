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
    // ⚠️ 백그라운드 녹음: Info.plist의 UIBackgroundModes에 "audio" 필수

    func activateRecordingSession() throws {
        let session = AVAudioSession.sharedInstance()
        
        try session.setCategory(
            .playAndRecord,
            mode: .measurement,
            options: [.defaultToSpeaker, .allowBluetoothA2DP, .allowBluetoothHFP, .allowAirPlay]
        )
        
        try session.setActive(true)
    }

    func activatePlaybackSession() throws {
        let session = AVAudioSession.sharedInstance()
        
        try session.setCategory(.playback, mode: .default)
        try session.setActive(true)
    }

    func deactivateSession() throws {
        try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }

    func requestMicrophonePermission() async -> Bool {
        return await AVAudioApplication.requestRecordPermission()
    }

    func checkMicrophonePermission() -> Bool {
        return AVAudioApplication.shared.recordPermission == .granted
    }
}
