//
//  RecordingDetailViewModel.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation
import Combine

/// 녹음 상세 화면의 비즈니스 로직
@Observable
final class RecordingDetailViewModel {

    // TODO: 의존성
    // - private let player: AudioPlayerProtocol
    // - private let audioSession: AudioSessionProtocol
    // - private let recording: Recording
    // - private var cancellables = Set<AnyCancellable>()

    // TODO: 상태 프로퍼티
    // - var playbackState: PlaybackState = .idle
    // - var currentTime: TimeInterval = 0
    // - var duration: TimeInterval = 0
    // - var seekPosition: Double = 0       ← 슬라이더 바인딩용 (0.0 ~ 1.0)
    // - var isPlaying: Bool = false
    // - var playbackProgress: Double = 0   ← 그래프 위 진행 표시용 (0.0 ~ 1.0)

    // TODO: 메서드
    //
    // 1. initialize()
    //    - player.statePublisher 구독
    //    - 상태 변경 시 currentTime, duration, isPlaying 업데이트
    //    - playbackProgress = currentTime / duration
    //
    // 2. togglePlayback()
    //    - idle/finished → audioSession.activatePlaybackSession()
    //                      player.play(url: recording.fileURL)
    //    - playing → player.pause()
    //    - paused → player.play(url:) (이어서 재생)
    //
    // 3. stopPlayback()
    //    - player.stop()
    //    - audioSession.deactivateSession()
    //    - seekPosition = 0
    //
    // 4. seek(to position: Double)
    //    - let time = position * duration
    //    - player.seek(to: time)
    //
    // 5. skip(seconds: TimeInterval)
    //    - let newTime = max(0, min(duration, currentTime + seconds))
    //    - player.seek(to: newTime)
}
