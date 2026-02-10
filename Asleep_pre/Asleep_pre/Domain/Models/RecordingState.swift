//
//  RecordingState.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// 녹음기의 현재 상태
enum RecordingState: Equatable {
    /// 녹음 대기 (초기 상태)
    case idle
    /// 마이크 권한 요청 중
    case requestingPermission
    /// 녹음 준비 완료
    case ready
    /// 녹음 중 (경과 시간, 현재 데시벨)
    case recording(duration: TimeInterval, decibel: Float)
    /// 녹음 일시정지
    case paused(duration: TimeInterval)
    /// 녹음 완료
    case stopped
    /// 오류 발생
    case error(RecordingError)
}

/// 녹음 관련 에러
enum RecordingError: Error, Equatable {
    /// 마이크 권한 거부
    case permissionDenied
    /// 오디오 세션 설정 실패
    case sessionSetupFailed
    /// 녹음기 초기화 실패
    case recorderInitFailed
    /// 파일 저장 실패
    case fileSaveFailed
    /// 알 수 없는 오류
    case unknown(String)
}
