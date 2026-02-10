//
//  AppConstants.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

enum AppConstants {
    /// 녹음 파일 저장 디렉토리명
    static let recordingsDirectoryName = "Recordings"

    /// 녹음 파일 확장자
    static let audioFileExtension = "m4a"

    /// 미터링 타이머 간격 (초) — 실시간 파형용
    static let meteringInterval: TimeInterval = 0.05

    /// 재생 진행률 업데이트 간격 (초)
    static let playbackUpdateInterval: TimeInterval = 0.1

    /// 건너뛰기 시간 (초)
    static let skipInterval: TimeInterval = 10.0

    /// 미터링 최소 데시벨 값 (무음)
    static let minDecibelLevel: Float = -160.0

    /// 미터링 최대 데시벨 값
    static let maxDecibelLevel: Float = 0.0
}
