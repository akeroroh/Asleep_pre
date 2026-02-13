//
//  RecordingViewModel.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation
import Combine
import UIKit

@Observable
@MainActor
final class RecordingViewModel {

    // MARK: - 의존성

    private let audioSession: AudioSessionProtocol
    private let recorder: AudioRecorderProtocol
    private let repository: RecordingRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - 상태 프로퍼티

    var recordingState: RecordingState = .idle
    var selectedQuality: AudioQuality = .high
    var elapsedTime: TimeInterval = 0
    var currentDecibel: Float = 0
    var liveMeteringLevels: [MeteringLevel] = []
    var showPermissionAlert: Bool = false
    var showSavedAlert: Bool = false
    var savedDuration: TimeInterval = 0
    var errorMessage: String?

    /// 현재 녹음 중인 파일의 URL
    private var currentFileURL: URL?
    /// 녹음 시작 시각
    private var recordingStartDate: Date?

    // MARK: - 편의 프로퍼티

    var isRecording: Bool {
        if case .recording = recordingState { return true }
        return false
    }

    var isPaused: Bool {
        if case .paused = recordingState { return true }
        return false
    }

    // MARK: - Init

    init(audioSession: AudioSessionProtocol, recorder: AudioRecorderProtocol, repository: RecordingRepositoryProtocol) {
        self.audioSession = audioSession
        self.recorder = recorder
        self.repository = repository
    }

    // MARK: - 초기화

    func initialize() {
        // 녹음 상태 구독
        recorder.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                self.recordingState = state

                switch state {
                case .recording(let duration, let decibel):
                    self.elapsedTime = duration
                    self.currentDecibel = decibel
                case .paused(let duration):
                    self.elapsedTime = duration
                case .stopped:
                    break
                case .error(let error):
                    self.errorMessage = "\(error)"
                default:
                    break
                }
            }
            .store(in: &cancellables)

        // 미터링 데이터 구독
        recorder.meteringPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] level in
                self?.liveMeteringLevels.append(level)
            }
            .store(in: &cancellables)

        // 포그라운드 복귀 시 경과 시간 동기화
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.syncElapsedTime()
            }
            .store(in: &cancellables)

        // 마이크 권한 요청
        Task {
            let granted = await audioSession.requestMicrophonePermission()
            if granted {
                recordingState = .ready
            } else {
                showPermissionAlert = true
                recordingState = .error(.permissionDenied)
            }
        }
    }

    // MARK: - 포그라운드 복귀 시 시간 동기화

    private func syncElapsedTime() {
        guard recorder.isRecording else { return }
        let actualTime = recorder.currentTime
        elapsedTime = actualTime
        recordingState = .recording(duration: actualTime, decibel: currentDecibel)
    }

    // MARK: - 녹음 토글

    func toggleRecording() {
        switch recordingState {
        case .idle, .ready, .stopped:
            startRecording()
        case .recording:
            stopRecording()
        default:
            break
        }
    }

    // MARK: - 녹음 시작

    private func startRecording() {
        do {
            try audioSession.activateRecordingSession()

            let fileURL = repository.generateNewFileURL()
            currentFileURL = fileURL
            recordingStartDate = Date()
            liveMeteringLevels = []
            elapsedTime = 0

            try recorder.startRecording(quality: selectedQuality, to: fileURL)
        } catch {
            errorMessage = "녹음 시작 실패: \(error.localizedDescription)"
            recordingState = .error(.sessionSetupFailed)
        }
    }

    // MARK: - 녹음 중지 & 저장

    private func stopRecording() {
        let duration = recorder.stopRecording() ?? elapsedTime
        savedDuration = duration

        guard let fileURL = currentFileURL else { return }

        let meteringFloats = liveMeteringLevels.map { $0.normalizedLevel }

        let recording = Recording(
            fileName: "녹음 \(DateFormatter.fileNameFormatter.string(from: recordingStartDate ?? Date()))",
            createdAt: recordingStartDate ?? Date(),
            duration: duration,
            fileURL: fileURL,
            meteringLevels: meteringFloats
        )

        do {
            try repository.save(recording)
        } catch {
            errorMessage = "녹음 저장 실패: \(error.localizedDescription)"
        }

        try? audioSession.deactivateSession()
        showSavedAlert = true

        currentFileURL = nil
        recordingStartDate = nil
        elapsedTime = 0
        recordingState = .ready
    }
}
