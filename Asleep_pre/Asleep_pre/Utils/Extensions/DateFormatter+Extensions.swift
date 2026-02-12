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

    /// 섹션 헤더용: "2026년 2월 10일 (월)"
    static let sectionDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    /// 타임라인 행 라벨용: "월 7/29"
    static let timelineRowFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E M/d"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    /// 시간만 표시: "23:30"
    static let timeOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    /// 파일명 생성용: "20260210_143025"
    static let fileNameFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HHmmss"
        return formatter
    }()
}
