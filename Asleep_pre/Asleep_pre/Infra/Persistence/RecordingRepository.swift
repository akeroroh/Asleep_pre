//
//  RecordingRepository.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// RecordingRepositoryProtocol의 구현체
/// - RecordingFileManager를 활용한 파일 관리
/// - JSON 파일로 메타데이터 영속화
final class RecordingRepository: RecordingRepositoryProtocol {

    private let fileManager: RecordingFileManager

    private var metadataFileURL: URL {
        fileManager.recordingsDirectory.appendingPathComponent("recordings.json")
    }

    init(fileManager: RecordingFileManager) {
        self.fileManager = fileManager
    }

    // MARK: - fetchAll

    func fetchAll() -> [Recording] {
        guard let data = try? Data(contentsOf: metadataFileURL),
              let recordings = try? JSONDecoder().decode([Recording].self, from: data) else {
            return []
        }

        // 실제 파일이 존재하는 것만 반환, 최신순 정렬
        return recordings
            .filter { fileManager.fileExists(at: $0.fileURL) }
            .sorted { $0.createdAt > $1.createdAt }
    }

    // MARK: - fetch(by:)

    func fetch(by id: UUID) -> Recording? {
        fetchAll().first { $0.id == id }
    }

    // MARK: - save

    func save(_ recording: Recording) throws {
        var recordings = loadAllFromDisk()

        // 중복 id 체크
        guard !recordings.contains(where: { $0.id == recording.id }) else { return }

        recordings.append(recording)
        try saveToDisk(recordings)
    }

    // MARK: - delete

    func delete(_ recording: Recording) throws {
        try fileManager.deleteFile(at: recording.fileURL)

        var recordings = loadAllFromDisk()
        recordings.removeAll { $0.id == recording.id }
        try saveToDisk(recordings)
    }

    // MARK: - generateNewFileURL

    func generateNewFileURL() -> URL {
        fileManager.generateFileURL()
    }

    // MARK: - Private

    private func loadAllFromDisk() -> [Recording] {
        guard let data = try? Data(contentsOf: metadataFileURL),
              let recordings = try? JSONDecoder().decode([Recording].self, from: data) else {
            return []
        }
        return recordings
    }

    private func saveToDisk(_ recordings: [Recording]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(recordings)
        try data.write(to: metadataFileURL, options: .atomic)
    }
}
