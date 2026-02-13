//
//  AudioQuality.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

enum AudioQuality: String, CaseIterable, Identifiable {
    case low = "저음질"
    case medium = "중음질"
    case high = "고음질"

    var id: String { rawValue }

    var sampleRate: Double {
        switch self {
        case .low: return 12_000.0
        case .medium: return 22_050.0
        case .high: return 48_000.0
        }
    }

    var bitRate: Int {
        switch self {
        case .low: return 32_000
        case .medium: return 64_000
        case .high: return 192_000
        }
    }
}
