//
//  RecordingListViewModel.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation
import SwiftUI

/// 녹음 목록 화면의 비즈니스 로직
@Observable
@MainActor
final class RecordingListViewModel {

    // MARK: - 의존성

    private let repository: RecordingRepositoryProtocol

    // MARK: - 상태 프로퍼티

    var recordings: [Recording] = []
    var isLoading: Bool = false
    var errorMessage: String?

    // MARK: - Init

    init(repository: RecordingRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - 녹음 목록 로드

    func loadRecordings() {
        isLoading = true
        recordings = repository.fetchAll()
        isLoading = false
    }

    // MARK: - 녹음 삭제 (IndexSet)

    func deleteRecordings(at offsets: IndexSet) {
        let toDelete = offsets.map { recordings[$0] }
        for recording in toDelete {
            do {
                try repository.delete(recording)
            } catch {
                errorMessage = "삭제 실패: \(error.localizedDescription)"
            }
        }
        recordings.remove(atOffsets: offsets)
    }

    // MARK: - 단일 녹음 삭제

    func deleteRecording(_ recording: Recording) {
        do {
            try repository.delete(recording)
            recordings.removeAll { $0.id == recording.id }
        } catch {
            errorMessage = "삭제 실패: \(error.localizedDescription)"
        }
    }
}
