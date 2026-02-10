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

    // TODO: 구현 목록
    //
    // 1. recordingsDirectory: URL
    //    - FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    //    - "Recordings" 서브디렉토리 생성
    //    - createDirectory(at:withIntermediateDirectories:true)
    //
    // 2. generateFileName() -> String
    //    - "Recording_yyyyMMdd_HHmmss.m4a" 형식
    //    - DateFormatter 활용
    //
    // 3. generateFileURL() -> URL
    //    - recordingsDirectory.appendingPathComponent(generateFileName())
    //
    // 4. fileExists(at url: URL) -> Bool
    //    - FileManager.default.fileExists(atPath: url.path)
    //
    // 5. deleteFile(at url: URL) throws
    //    - FileManager.default.removeItem(at: url)
    //
    // 6. listFiles() -> [URL]
    //    - FileManager.default.contentsOfDirectory(at:, includingPropertiesForKeys:)
    //    - .m4a 파일만 필터링
    //    - 생성일 기준 정렬
}
