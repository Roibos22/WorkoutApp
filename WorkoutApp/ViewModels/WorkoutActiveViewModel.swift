//
//  WorkoutActiveViewModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 05.08.24.
//

import Foundation
import SwiftUI
import Combine

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
    private let appState: AppState

    init(workoutViewModel: WorkoutDetailViewModel,workout: Workout, workoutTimeline: [Activity], appState: AppState) {
        self.workoutViewModel = workoutViewModel
        self.workout = workout
        self.workoutTimeline = workoutTimeline
        self.workoutTimeLeft = workout.duration
        self.currentActivityTimeLeft = workoutTimeline[0].duration
        self.appState = appState

        setupTimerSubscription()
    }

    var currentActivity: Activity { workoutTimeline[activityIndex] }
    var isRestActivity: Bool { currentActivity.title == "Rest" }
    var nextActivity: Activity? {
        guard activityIndex + 1 < workoutTimeline.count else { return nil }
        return workoutTimeline[activityIndex + 1]
    }
    
    func getSoundsEnabled() -> Bool {
        return appState.soundsEnabled
    }
    
    func resetWorkout() {
        isRunning = false
        isPaused = false
        activityIndex = 0
        workoutTimeLeft = workout.duration
        currentActivityTimeLeft = currentActivity.duration
        currentActivityDurationDone = 0.0
        celebrationSoundPlayed = false
    }

    func skipActivity() {
        if activityIndex == workoutTimeline.count - 2 {
            finishWorkoutToCompletedView()
        } else {
            workoutTimeLeft -= currentActivityTimeLeft
            activityIndex += 1
            currentActivityTimeLeft = currentActivity.duration
            currentActivityDurationDone = 0.0
            SoundManager.instance.stopSound()
        }
    }

    func togglePause() {
        isPaused.toggle()
        isRunning = !isPaused
        if isPaused == true {
            SoundManager.instance.pauseSound()
        } else {
            SoundManager.instance.resumeSound()
        }
    }

    func finishWorkoutToCompletedView() {
        isRunning = false
        showCompletedView = true
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
            DispatchQueue.main.async {
                SoundManager.instance.playSound(sound: .countdown)
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
}
