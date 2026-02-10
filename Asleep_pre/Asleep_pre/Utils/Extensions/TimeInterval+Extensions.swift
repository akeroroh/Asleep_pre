//
//  TimeInterval+Extensions.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

extension TimeInterval {
    /// "MM:SS" 형식으로 변환
    var formattedTime: String {
        let totalSeconds = Int(self)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    /// "HH:MM:SS" 형식으로 변환 (1시간 이상일 경우)
    var formattedLongTime: String {
        let totalSeconds = Int(self)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
