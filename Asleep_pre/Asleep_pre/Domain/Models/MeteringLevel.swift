//
//  MeteringLevel.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// 특정 시점의 오디오 미터링 데이터
struct MeteringLevel: Identifiable, Codable {
    let id: UUID
    /// 녹음 시작 기준 경과 시간 (초)
    let time: TimeInterval
    /// 평균 데시벨 값 (-160 ~ 0)
    let averagePower: Float
    /// 피크 데시벨 값 (-160 ~ 0)
    let peakPower: Float
    /// 0.0 ~ 1.0 정규화된 레벨 (그래프 표시용)
    var normalizedLevel: Float {
        let minDb: Float = -160.0
        
        if averagePower < minDb {
            return 0.0
        }
        
        if averagePower >= 0.0 {
            return 1.0
        }
        
        // dB 범위: -160 ~ 0 → 0.0 ~ 1.0
        return (averagePower - minDb) / abs(minDb)
    }

    init(id: UUID = UUID(), time: TimeInterval, averagePower: Float, peakPower: Float) {
        self.id = id
        self.time = time
        self.averagePower = averagePower
        self.peakPower = peakPower
    }
}
