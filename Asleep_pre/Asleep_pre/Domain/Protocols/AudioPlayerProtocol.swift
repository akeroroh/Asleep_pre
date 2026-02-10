//
//  AudioPlayerProtocol.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation
import Combine

/// 오디오 재생 추상화
/// - AVAudioPlayer를 직접 노출하지 않고 프로토콜로 추상화
protocol AudioPlayerProtocol {
    /// 현재 재생 상태
    var statePublisher: AnyPublisher<PlaybackState, Never> { get }

    /// 오디오 파일 재생
    /// - Parameter url: 재생할 파일 경로
    func play(url: URL) throws

    /// 재생 일시정지
    func pause()

    /// 재생 정지 (처음으로 되감기)
    func stop()

    /// 특정 시점으로 이동
    /// - Parameter time: 이동할 시점 (초)
    func seek(to time: TimeInterval)

    /// 현재 재생 위치
    var currentTime: TimeInterval { get }

    /// 전체 재생 길이
    var duration: TimeInterval { get }

    /// 재생 중 여부
    var isPlaying: Bool { get }
}
