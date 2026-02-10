//
//  DateFormatter+Extensions.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

extension DateFormatter {
    /// 녹음 목록 표시용: "2026.02.10 14:30"
    static let recordingDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    /// 파일명 생성용: "20260210_143025"
    static let fileNameFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        return formatter
    }()
}
