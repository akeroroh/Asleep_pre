//
//  AudioRecorderService.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import AVFoundation
import Combine

/// AudioRecorderProtocol의 구현체
/// - AVAudioRecorder를 래핑하여 녹음 기능 제공
/// - Timer 기반 실시간 미터링 데이터 수집
final class AudioRecorderService: NSObject, AudioRecorderProtocol {

    // TODO: 프로퍼티 선언
    // - private var audioRecorder: AVAudioRecorder?
    // - private var meteringTimer: Timer?
    // - private let stateSubject = CurrentValueSubject<RecordingState, Never>(.idle)
    // - private let meteringSubject = PassthroughSubject<MeteringLevel, Never>()

    // TODO: statePublisher / meteringPublisher 구현
    //   stateSubject.eraseToAnyPublisher()
    //   meteringSubject.eraseToAnyPublisher()

    var statePublisher: AnyPublisher<RecordingState, Never> {
        // TODO: 구현
        Just(.idle).eraseToAnyPublisher()
    }

    var meteringPublisher: AnyPublisher<MeteringLevel, Never> {
        // TODO: 구현
        Empty().eraseToAnyPublisher()
    }

    var currentTime: TimeInterval {
        // TODO: audioRecorder?.currentTime ?? 0
        return 0
    }

    var isRecording: Bool {
        // TODO: audioRecorder?.isRecording ?? false
        return false
    }

    func startRecording(quality: AudioQuality, to fileURL: URL) throws {
        // TODO: 구현 순서
        // 1. AudioQuality에서 녹음 설정(settings) 딕셔너리 생성
        //    - AVFormatIDKey: kAudioFormatMPEG4AAC
        //    - AVSampleRateKey: quality.sampleRate
        //    - AVNumberOfChannelsKey: 1 (모노)
        //    - AVEncoderAudioQualityKey: AVAudioQuality 매핑
        //    - AVEncoderBitRateKey: quality.bitRate
        //
        // 2. AVAudioRecorder(url:settings:) 초기화
        // 3. recorder.isMeteringEnabled = true
        // 4. recorder.delegate = self
        // 5. recorder.record()
        //
        // 6. 미터링 타이머 시작 (0.05초 간격)
        //    - recorder.updateMeters()
        //    - averagePower(forChannel: 0)
        //    - peakPower(forChannel: 0)
        //    - MeteringLevel 생성 → meteringSubject.send()
        //
        // 7. stateSubject.send(.recording(...))
    }

    func pauseRecording() {
        // TODO: audioRecorder?.pause()
        // stateSubject.send(.paused(duration: currentTime))
    }

    func resumeRecording() {
        // TODO: audioRecorder?.record()
        // stateSubject.send(.recording(...))
    }

    func stopRecording() -> TimeInterval? {
        // TODO: 구현 순서
        // 1. 미터링 타이머 정지 (invalidate)
        // 2. let duration = audioRecorder?.currentTime
        // 3. audioRecorder?.stop()
        // 4. audioRecorder = nil
        // 5. stateSubject.send(.stopped)
        // 6. return duration
        return nil
    }

    // TODO: AVAudioRecorderDelegate 구현
    // - audioRecorderDidFinishRecording(_:successfully:)
    // - audioRecorderEncodeErrorDidOccur(_:error:)
}
