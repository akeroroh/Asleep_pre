//
//  RecordingFileManager.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// 녹음 파일의 물리적 파일 시스템 관리
/// - Documents/Recordings/ 디렉토리에 파일 저장
/// - 파일 존재 여부 확인, 삭제, 목록 조회
final class RecordingFileManager {

    // MARK: - 녹음 디렉토리

    var recordingsDirectory: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let recordingsURL = documentsURL.appendingPathComponent("Recordings", isDirectory: true)

        if !FileManager.default.fileExists(atPath: recordingsURL.path) {
            try? FileManager.default.createDirectory(at: recordingsURL, withIntermediateDirectories: true)
        }

        return recordingsURL
    }

    // MARK: - 파일명 생성

    func generateFileName() -> String {
        "Recording_\(DateFormatter.fileNameFormatter.string(from: Date())).m4a"
    }

    func generateFileURL() -> URL {
        recordingsDirectory.appendingPathComponent(generateFileName())
    }

    // MARK: - 파일 존재 확인

    func fileExists(at url: URL) -> Bool {
        FileManager.default.fileExists(atPath: url.path)
    }

    // MARK: - 파일 삭제

    func deleteFile(at url: URL) throws {
        guard fileExists(at: url) else { return }
        try FileManager.default.removeItem(at: url)
    }

    // MARK: - 파일 목록

    func listFiles() -> [URL] {
        guard let contents = try? FileManager.default.contentsOfDirectory(
            at: recordingsDirectory,
            includingPropertiesForKeys: [.creationDateKey],
            options: .skipsHiddenFiles
        ) else {
            return []
        }

        return contents
            .filter { $0.pathExtension == "m4a" }
            .sorted { url1, url2 in
                let date1 = (try? url1.resourceValues(forKeys: [.creationDateKey]))?.creationDate ?? .distantPast
                let date2 = (try? url2.resourceValues(forKeys: [.creationDateKey]))?.creationDate ?? .distantPast
                return date1 > date2
            }
    }
}
