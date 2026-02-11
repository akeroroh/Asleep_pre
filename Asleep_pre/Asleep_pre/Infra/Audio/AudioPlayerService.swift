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

    private var audioPlayer: AVAudioPlayer?
    private var progressTimer: Timer?
    private let stateSubject = CurrentValueSubject<PlaybackState, Never>(.idle)

    var statePublisher: AnyPublisher<PlaybackState, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    var currentTime: TimeInterval {
        audioPlayer?.currentTime ?? 0
    }

    var duration: TimeInterval {
        audioPlayer?.duration ?? 0
    }

    var isPlaying: Bool {
        audioPlayer?.isPlaying ?? false
    }

    func play(url: URL) throws {
        stop()
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            stateSubject.send(.playing(currentTime: currentTime, duration: duration))
        } catch {
            stateSubject.send(.error(.unknown(<#String#>)))
            throw error
        }
    }
    

    func pause() {
        audioPlayer?.pause()
        progressTimer?.invalidate()
        stateSubject.send(.paused(currentTime: currentTime, duration: duration))
    }

    func stop() {
        progressTimer?.invalidate()
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        stateSubject.send(.idle)
    }

    func seek(to time: TimeInterval) {
        audioPlayer?.currentTime = time
        if isPlaying {
            stateSubject.send(.playing(currentTime: currentTime, duration: duration))
        } else {
            stateSubject.send(.paused(currentTime: currentTime, duration: duration))
        }
    }
    
}


extension AudioPlayerService: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer?.invalidate()
        stateSubject.send(.finished)
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            stateSubject.send(.error(.unknown(<#String#>)))
        }
    }
}
