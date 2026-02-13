//
//  RecordingDetailViewModel.swift
//  Asleep_pre
//
//  Created by jinahyun on 2/10/26.
//

import Foundation
import Combine

/// 녹음 상세 화면의 비즈니스 로직
@Observable
@MainActor
final class RecordingDetailViewModel {

    // MARK: - 의존성

    private let player: AudioPlayerProtocol
    private let audioSession: AudioSessionProtocol
    let recording: Recording
    private var cancellables = Set<AnyCancellable>()

    // MARK: - 상태 프로퍼티

    var playbackState: PlaybackState = .idle
    var currentTime: TimeInterval = 0
    var duration: TimeInterval = 0
    var seekPosition: Double = 0
    var isPlaying: Bool = false
    var playbackProgress: Double = 0
    var errorMessage: String?

    // MARK: - Init

    init(player: AudioPlayerProtocol, audioSession: AudioSessionProtocol, recording: Recording) {
        self.player = player
        self.audioSession = audioSession
        self.recording = recording
        self.duration = recording.duration
    }

    // MARK: - 초기화

    func initialize() {
        player.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                self.playbackState = state

                switch state {
                case .playing(let time, let dur):
                    self.currentTime = time
                    self.duration = dur
                    self.isPlaying = true
                    self.updateProgress()
                case .paused(let time, let dur):
                    self.currentTime = time
                    self.duration = dur
                    self.isPlaying = false
                    self.updateProgress()
                case .finished:
                    self.isPlaying = false
                    self.currentTime = 0
                    self.seekPosition = 0
                    self.playbackProgress = 0
                    try? self.audioSession.deactivateSession()
                case .error(let error):
                    self.isPlaying = false
                    self.errorMessage = "\(error)"
                case .idle:
                    self.isPlaying = false
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - 재생 토글

    func togglePlayback() {
        switch playbackState {
        case .idle, .finished:
            do {
                try audioSession.activatePlaybackSession()
                try player.play(url: recording.fileURL)
                startProgressTimer()
            } catch {
                errorMessage = "재생 실패: \(error.localizedDescription)"
            }
        case .playing:
            player.pause()
            progressTimer?.invalidate()
        case .paused:
            do {
                try player.play(url: recording.fileURL)
                startProgressTimer()
            } catch {
                errorMessage = "재생 재개 실패: \(error.localizedDescription)"
            }
        default:
            break
        }
    }

    // MARK: - 재생 정지

    func stopPlayback() {
        progressTimer?.invalidate()
        player.stop()
        try? audioSession.deactivateSession()
        seekPosition = 0
        playbackProgress = 0
        currentTime = 0
    }

    // MARK: - 탐색

    func seek(to position: Double) {
        let time = position * duration
        player.seek(to: time)
        seekPosition = position
        playbackProgress = position
        currentTime = time
    }

    // MARK: - 스킵

    func skip(seconds: TimeInterval) {
        let newTime = max(0, min(duration, currentTime + seconds))
        player.seek(to: newTime)
        currentTime = newTime
        updateProgress()
    }

    // MARK: - Progress Timer

    private var progressTimer: Timer?

    private func startProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.currentTime = self.player.currentTime
            self.duration = self.player.duration > 0 ? self.player.duration : self.recording.duration
            self.updateProgress()
        }
    }

    private func updateProgress() {
        guard duration > 0 else { return }
        let progress = currentTime / duration
        seekPosition = progress
        playbackProgress = progress
    }


    /// View의 onDisappear에서 호출됨 — 리소스 정리
    func cleanup() {
        progressTimer?.invalidate()
        progressTimer = nil
        cancellables.removeAll()
        player.stop()
        try? audioSession.deactivateSession()
    }
}
