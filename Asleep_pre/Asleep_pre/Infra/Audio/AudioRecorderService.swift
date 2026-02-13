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
    
    private var audioRecorder: AVAudioRecorder?
    private var meteringTimer: Timer?
    private var stateSubject = CurrentValueSubject<RecordingState, Never>(.idle)
    private let meteringSubject = PassthroughSubject<MeteringLevel, Never>()


    var statePublisher: AnyPublisher<RecordingState, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    var meteringPublisher: AnyPublisher<MeteringLevel, Never> {
        meteringSubject.eraseToAnyPublisher()
    }

    var currentTime: TimeInterval {
        audioRecorder?.currentTime ?? 0
    }

    var isRecording: Bool {
        audioRecorder?.isRecording ?? false
    }

    func startRecording(quality: AudioQuality, to fileURL: URL) throws {
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: quality.sampleRate,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: quality.bitRate
        ]
        
        audioRecorder = try AVAudioRecorder(url: fileURL, settings: settings)
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.delegate = self

        if audioRecorder?.record() == true {
            startMeteringTimer()
        } else {
            stateSubject.send(.error(.unknown("녹음 시작에 실패했습니다")))
        }
    }
    
    private func startMeteringTimer() {
        meteringTimer?.invalidate()
        
        meteringTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { [weak self] _ in
            guard let self = self, let recorder = self.audioRecorder else { return }
            
            recorder.updateMeters()
            
            let average = recorder.averagePower(forChannel: 0)
            let peak = recorder.peakPower(forChannel: 0)
            let currentRecordTime = self.currentTime
            
            let level = MeteringLevel(time: currentRecordTime, averagePower: average, peakPower: peak)
            self.meteringSubject.send(level)
            
            self.stateSubject.send(.recording(duration: self.currentTime, decibel: average))
        })
    }

    func pauseRecording() {
        audioRecorder?.pause()
        meteringTimer?.invalidate()
        stateSubject.send(.paused(duration: currentTime))
    }

    func resumeRecording() {
        audioRecorder?.record()
        startMeteringTimer()
    }

    func stopRecording() -> TimeInterval? {
        meteringTimer?.invalidate()
        let duration = audioRecorder?.currentTime
        
        audioRecorder?.stop()
        audioRecorder = nil
        
        stateSubject.send(.stopped)
        return duration
    }
}

extension AudioRecorderService: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        meteringTimer?.invalidate()
        if !flag {
            stateSubject.send(.error(.unknown("녹음이 비정상적으로 종료되었습니다")))
        }
    }

    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        stateSubject.send(.error(.unknown(error?.localizedDescription ?? "인코딩 오류가 발생했습니다")))
    }
}
