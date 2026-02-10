//
//  AudioSessionProtocol.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// 오디오 세션 관리 추상화
/// - AVAudioSession의 카테고리/모드 설정을 캡슐화
/// - 백그라운드 녹음, 마이크 권한을 담당
protocol AudioSessionProtocol {
    /// 녹음용 오디오 세션 활성화
    /// - category: .playAndRecord
    /// - mode: .default
    /// - options: .defaultToSpeaker
    func activateRecordingSession() throws

    /// 재생용 오디오 세션 활성화
    /// - category: .playback
    func activatePlaybackSession() throws

    /// 오디오 세션 비활성화
    func deactivateSession() throws

    /// 마이크 사용 권한 요청
    /// - Returns: 권한 허용 여부
    func requestMicrophonePermission() async -> Bool

    /// 현재 마이크 권한 상태 확인
    func checkMicrophonePermission() -> Bool
}
