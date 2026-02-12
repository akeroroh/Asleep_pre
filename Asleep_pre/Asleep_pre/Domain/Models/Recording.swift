//
//  Recording.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

struct Recording: Identifiable, Codable, Hashable {
    let id: UUID
    let fileName: String
    let createdAt: Date
    let duration: TimeInterval
    let fileURL: URL
    var meteringLevels: [Float]

    init(id: UUID = UUID(), fileName: String, createdAt: Date = Date(), duration: TimeInterval, fileURL: URL, meteringLevels: [Float] = []) {
        self.id = id
        self.fileName = fileName
        self.createdAt = createdAt
        self.duration = duration
        self.fileURL = fileURL
        self.meteringLevels = meteringLevels
    }
}
