//
//  RecordingListViewModel.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation

/// 녹음 목록 화면의 비즈니스 로직
@Observable
final class RecordingListViewModel {

    // TODO: 의존성
    // - private let repository: RecordingRepositoryProtocol

    // TODO: 상태 프로퍼티
    // - var recordings: [Recording] = []
    // - var isLoading: Bool = false

    // TODO: 메서드
    //
    // 1. loadRecordings()
    //    - recordings = repository.fetchAll()
    //    - createdAt 기준 내림차순 정렬
    //
    // 2. deleteRecordings(at offsets: IndexSet)
    //    - offsets에 해당하는 Recording 삭제
    //    - repository.delete(recording)
    //    - recordings에서 제거
    //    - ⚠️ 삭제 실패 시 에러 핸들링
    //
    // 3. deleteRecording(_ recording: Recording)
    //    - 단일 항목 삭제
    //
    // 4. formattedDate(for recording: Recording) -> String
    //    - DateFormatter.recordingDateFormatter 활용
    //
    // 5. formattedDuration(for recording: Recording) -> String
    //    - recording.duration.formattedTime 활용
}
