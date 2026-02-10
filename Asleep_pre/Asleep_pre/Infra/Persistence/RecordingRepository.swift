//
//  RecordingRepository.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// RecordingRepositoryProtocol의 구현체
/// - RecordingFileManager를 활용한 파일 관리
/// - UserDefaults 또는 JSON 파일로 메타데이터 영속화
final class RecordingRepository: RecordingRepositoryProtocol {

    // TODO: 의존성
    // - private let fileManager: RecordingFileManager
    // - 메타데이터 저장소 (UserDefaults 또는 recordings.json)

    // TODO: 구현 목록
    //
    // 1. fetchAll() -> [Recording]
    //    - 메타데이터 저장소에서 [Recording] 디코딩
    //    - 파일 존재 여부 검증 (삭제된 파일 필터링)
    //    - createdAt 기준 내림차순 정렬
    //
    // 2. fetch(by id: UUID) -> Recording?
    //    - fetchAll()에서 id로 검색
    //
    // 3. save(_ recording: Recording) throws
    //    - 기존 목록에 append
    //    - 메타데이터 저장소에 인코딩하여 저장
    //    - ⚠️ 중복 id 체크
    //
    // 4. delete(_ recording: Recording) throws
    //    - fileManager.deleteFile(at: recording.fileURL)
    //    - 메타데이터 저장소에서 제거
    //
    // 5. generateNewFileURL() -> URL
    //    - fileManager.generateFileURL()

    func fetchAll() -> [Recording] {
        // TODO: 구현
        return []
    }

    func fetch(by id: UUID) -> Recording? {
        // TODO: 구현
        return nil
    }

    func save(_ recording: Recording) throws {
        // TODO: 구현
    }

    func delete(_ recording: Recording) throws {
        // TODO: 구현
    }

    func generateNewFileURL() -> URL {
        // TODO: 구현
        return URL(fileURLWithPath: "")
    }
}
