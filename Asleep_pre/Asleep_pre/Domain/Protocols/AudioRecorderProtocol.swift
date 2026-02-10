//
//  AudioRecorderProtocol.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation
import Combine

/// 오디오 녹음 추상화
/// - AVAudioRecorder를 직접 노출하지 않고 프로토콜로 추상화
protocol AudioRecorderProtocol {
    /// 현재 녹음 상태
    var statePublisher: AnyPublisher<RecordingState, Never> { get }

    /// 실시간 미터링 데이터 스트림
    var meteringPublisher: AnyPublisher<MeteringLevel, Never> { get }

    /// 녹음 시작
    /// - Parameter quality: 음질 설정
    /// - Parameter fileURL: 저장할 파일 경로
    func startRecording(quality: AudioQuality, to fileURL: URL) throws

    /// 녹음 일시정지
    func pauseRecording()

    /// 녹음 재개
    func resumeRecording()

    /// 녹음 중지 및 파일 저장
    /// - Returns: 녹음된 파일의 길이 (초)
    func stopRecording() -> TimeInterval?

    /// 현재 녹음 경과 시간
    var currentTime: TimeInterval { get }

    /// 녹음 중 여부
    var isRecording: Bool { get }
}
