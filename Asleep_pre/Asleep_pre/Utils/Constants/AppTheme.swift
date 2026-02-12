//
//  AppTheme.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import SwiftUI

enum AppTheme {
    // 배경
    static let background = Color(red: 0.07, green: 0.06, blue: 0.18)
    static let cardBackground = Color.white.opacity(0.06)
    static let cardBorder = Color.white.opacity(0.12)

    // 액센트 (퍼플/라벤더)
    static let accent = Color(red: 0.5, green: 0.4, blue: 0.85)
    static let accentLight = Color(red: 0.6, green: 0.55, blue: 0.9)
    static let accentGlow = Color(red: 0.5, green: 0.4, blue: 0.85).opacity(0.3)

    // 텍스트
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.6)
    static let textTertiary = Color.white.opacity(0.35)

    // 녹음 버튼
    static let recordActive = Color(red: 0.9, green: 0.3, blue: 0.4)
    static let recordIdle = Color(red: 0.5, green: 0.4, blue: 0.85)

    // 그라데이션
    static let barGradient = LinearGradient(
        colors: [accent, accentLight],
        startPoint: .leading,
        endPoint: .trailing
    )
}
