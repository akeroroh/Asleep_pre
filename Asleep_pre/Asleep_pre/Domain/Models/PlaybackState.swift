//
//  PlaybackState.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// 오디오 재생기의 현재 상태
enum PlaybackState: Equatable {
    /// 재생 대기
    case idle
    /// 재생 중 (현재 위치, 전체 길이)
    case playing(currentTime: TimeInterval, duration: TimeInterval)
    /// 일시정지 (현재 위치, 전체 길이)
    case paused(currentTime: TimeInterval, duration: TimeInterval)
    /// 재생 완료
    case finished
    /// 오류
    case error(PlaybackError)
}

/// 재생 관련 에러
enum PlaybackError: Error, Equatable {
    /// 파일을 찾을 수 없음
    case fileNotFound
    /// 지원하지 않는 포맷
    case unsupportedFormat
    /// 플레이어 초기화 실패
    case playerInitFailed
    /// 알 수 없는 오류
    case unknown(String)
}
