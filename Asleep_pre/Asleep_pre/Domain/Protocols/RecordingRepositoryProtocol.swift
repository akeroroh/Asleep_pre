//
//  RecordingRepositoryProtocol.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// 녹음 파일 저장소 추상화
/// - 파일 시스템 접근을 캡슐화
/// - CRUD 오퍼레이션 제공
protocol RecordingRepositoryProtocol {
    /// 저장된 모든 녹음 목록 조회
    func fetchAll() -> [Recording]

    /// 특정 녹음 조회
    func fetch(by id: UUID) -> Recording?

    /// 녹음 메타데이터 저장 (녹음 완료 후)
    func save(_ recording: Recording) throws

    /// 녹음 삭제 (파일 + 메타데이터)
    func delete(_ recording: Recording) throws

    /// 새 녹음 파일의 URL 생성
    /// - Returns: 녹음 파일을 저장할 경로
    func generateNewFileURL() -> URL
}
