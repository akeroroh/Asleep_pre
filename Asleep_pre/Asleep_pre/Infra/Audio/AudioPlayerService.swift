//
//  AudioPlayerService.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import AVFoundation
import Combine

/// AudioPlayerProtocol의 구현체
/// - AVAudioPlayer를 래핑하여 재생 기능 제공
/// - Timer 기반 재생 진행률 업데이트
final class AudioPlayerService: NSObject, AudioPlayerProtocol {

    // TODO: 프로퍼티 선언
    // - private var audioPlayer: AVAudioPlayer?
    // - private var progressTimer: Timer?
    // - private let stateSubject = CurrentValueSubject<PlaybackState, Never>(.idle)

    var statePublisher: AnyPublisher<PlaybackState, Never> {
        // TODO: stateSubject.eraseToAnyPublisher()
        Just(.idle).eraseToAnyPublisher()
    }

    var currentTime: TimeInterval {
        // TODO: audioPlayer?.currentTime ?? 0
        return 0
    }

    var duration: TimeInterval {
        // TODO: audioPlayer?.duration ?? 0
        return 0
    }

    var isPlaying: Bool {
        // TODO: audioPlayer?.isPlaying ?? false
        return false
    }

    func play(url: URL) throws {
        // TODO: 구현 순서
        // 1. AVAudioPlayer(contentsOf: url) 초기화
        // 2. player.delegate = self
        // 3. player.prepareToPlay()
        // 4. player.play()
        //
        // 5. 프로그레스 타이머 시작 (0.1초 간격)
        //    - stateSubject.send(.playing(currentTime:, duration:))
        //
        // ⚠️ 이미 재생 중이면 stop() 후 새로 play
    }

    func pause() {
        // TODO: audioPlayer?.pause()
        // progressTimer?.invalidate()
        // stateSubject.send(.paused(currentTime:, duration:))
    }

    func stop() {
        // TODO: 구현 순서
        // 1. progressTimer?.invalidate()
        // 2. audioPlayer?.stop()
        // 3. audioPlayer?.currentTime = 0
        // 4. stateSubject.send(.idle)
    }

    func seek(to time: TimeInterval) {
        // TODO: audioPlayer?.currentTime = time
        // 현재 상태에 따라 playing/paused 상태 업데이트
    }

    // TODO: AVAudioPlayerDelegate 구현
    // - audioPlayerDidFinishPlaying(_:successfully:)
    //   progressTimer?.invalidate()
    //   stateSubject.send(.finished)
    //
    // - audioPlayerDecodeErrorDidOccur(_:error:)
    //   stateSubject.send(.error(.unknown(...)))
}
