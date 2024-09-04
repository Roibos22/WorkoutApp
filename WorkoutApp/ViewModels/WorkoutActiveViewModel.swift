//
//  WorkoutActiveViewModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 05.08.24.
//
import Foundation
import SwiftUI
import Combine
import ActivityKit
import AVFoundation
import UIKit

class WorkoutActiveViewModel: ObservableObject {
    @Published var workout: Workout
    @Published var workoutTimeline: [Activity]
    @Published var workoutTimeLeft: Double
    @Published var currentActivityTimeLeft: Double
    @Published var isRunning = false
    @Published var showCompletedView = false
    @Published var isPaused = false
    @Published var celebrationSoundPlayed = false
    @Published var circleProgress = 0.0
    @Published var barProgress = 0.0
    @Published var activityIndex = 0

    let workoutViewModel: WorkoutDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    private var countdownPlayed = false
    var currentActivityDurationDone = 0.0
    private var workoutDurationDone = 0.0
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    private var audioPlayer: AVAudioPlayer?
    private let appState: AppState

    init(workoutViewModel: WorkoutDetailViewModel, workout: Workout, workoutTimeline: [Activity], appState: AppState) {
        self.workoutViewModel = workoutViewModel
        self.workout = workout
        self.workoutTimeline = workoutTimeline
        self.workoutTimeLeft = workout.duration
        self.currentActivityTimeLeft = workoutTimeline[0].duration
        self.appState = appState

        setupTimerSubscription()
        setupBackgroundHandling()
        setupAudioSession()
        startLiveActivity()
    }

    var currentActivity: Activity { workoutTimeline[activityIndex] }
    var isRestActivity: Bool { currentActivity.title == "Rest" }
    var nextActivity: Activity? {
        guard activityIndex + 1 < workoutTimeline.count else { return nil }
        return workoutTimeline[activityIndex + 1]
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers, .duckOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }

    private func setupBackgroundHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    @objc private func appMovedToBackground() {
        guard isRunning else { return }
        startBackgroundAudio()
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
    }

    @objc private func appMovedToForeground() {
        stopBackgroundAudio()
        endBackgroundTask()
    }

    private func startBackgroundAudio() {
        guard audioPlayer == nil else { return }
        
        guard let audioURL = Bundle.main.url(forResource: "silence", withExtension: "mp3") else {
            print("Silent audio file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitely
            audioPlayer?.volume = 0.01 // Set volume very low
            audioPlayer?.play()
        } catch {
            print("Failed to initialize audio player: \(error)")
        }
    }

    private func stopBackgroundAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
    }

    private func endBackgroundTask() {
        guard backgroundTask != .invalid else { return }
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }

    func startLiveActivity() {
        // Your existing startLiveActivity implementation
    }
    
    func getSoundsEnabled() -> Bool {
        return UserDefaults.standard.hasSoundsEnabled
    }
    
    func resetWorkout() {
        isRunning = false
        isPaused = false
        activityIndex = 0
        workoutTimeLeft = workout.duration
        currentActivityTimeLeft = currentActivity.duration
        currentActivityDurationDone = 0.0
        celebrationSoundPlayed = false
        stopBackgroundAudio()
        endBackgroundTask()
    }

    func skipActivity() {
        if activityIndex == workoutTimeline.count - 2 {
            finishWorkoutToCompletedView()
        } else {
            workoutTimeLeft -= currentActivityTimeLeft
            activityIndex += 1
            currentActivityTimeLeft = currentActivity.duration
            currentActivityDurationDone = 0.0
            if getSoundsEnabled() {
                SoundManager.instance.stopSound()
            }
        }
    }

    func togglePause() {
        isPaused.toggle()
        isRunning = !isPaused
        if isPaused {
            stopBackgroundAudio()
            if getSoundsEnabled() {
                SoundManager.instance.pauseSound()
            }
        } else {
            if UIApplication.shared.applicationState == .background {
                startBackgroundAudio()
            }
            if getSoundsEnabled() {
                SoundManager.instance.resumeSound()
            }
        }
    }

    func finishWorkoutToCompletedView() {
        isRunning = false
        showCompletedView = true
        stopBackgroundAudio()
        endBackgroundTask()
    }
    
    func finishWorkoutFinal() {
        resetWorkout()
        showCompletedView = false
        appState.saveCompletedWorkoutSession(workout)
        workoutViewModel.workout.completions += 1
        workoutViewModel.saveWorkout()
    }

    private func setupTimerSubscription() {
        timer.sink { [weak self] _ in
            guard let self = self, self.isRunning else { return }
            
            self.updateTimers()
            self.checkActivityCompletion()
            self.updateProgress()
        }.store(in: &cancellables)
    }

    private func updateTimers() {
        currentActivityTimeLeft -= 0.01
        workoutTimeLeft -= 0.01
        currentActivityDurationDone += 0.01
        if appState.soundsEnabled && currentActivityTimeLeft < 3 && !countdownPlayed {
            if getSoundsEnabled() {
                DispatchQueue.main.async {
                    SoundManager.instance.playSound(sound: .countdown)
                }
            }
            countdownPlayed = true
        }
    }

    private func checkActivityCompletion() {
        if currentActivityTimeLeft <= 0 {
            if activityIndex == workoutTimeline.count - 2 {
                finishWorkoutToCompletedView()
            } else {
                activityIndex += 1
                currentActivityTimeLeft = currentActivity.duration
                countdownPlayed = false
            }
        }
    }

    private func updateProgress() {
        circleProgress = 1 - (currentActivityTimeLeft / currentActivity.duration)
        barProgress = (workout.duration - workoutTimeLeft) / workout.duration
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
