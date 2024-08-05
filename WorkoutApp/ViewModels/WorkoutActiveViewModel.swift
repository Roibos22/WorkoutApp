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
    @Published var isRunning = true
    @Published var isFinished = false
    @Published var isPaused = false
    @Published var showSkipped = false
    @Published var circleProgress = 0.0
    @Published var barProgress = 0.0
    @Published var activityIndex = 0

    private var cancellables = Set<AnyCancellable>()
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    init(workout: Workout, workoutTimeline: [Activity]) {
        self.workout = workout
        self.workoutTimeline = workoutTimeline
        self.workoutTimeLeft = workout.duration
        self.currentActivityTimeLeft = workoutTimeline[0].duration

        setupTimerSubscription()
    }

    var currentActivity: Activity { workoutTimeline[activityIndex] }
    var isRestActivity: Bool { currentActivity.title == "Rest" }
    var nextActivity: Activity? {
        guard activityIndex + 1 < workoutTimeline.count else { return nil }
        return workoutTimeline[activityIndex + 1]
    }

    func skipActivity() {
        if activityIndex == workoutTimeline.count - 2 {
            finishWorkout()
        } else {
            workoutTimeLeft -= currentActivityTimeLeft
            activityIndex += 1
            currentActivityTimeLeft = currentActivity.duration
            showSkipped = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.showSkipped = false
            }
        }
    }

    func togglePause() {
        isPaused.toggle()
        isRunning = !isPaused
    }

    func finishWorkout() {
        isRunning = false
        isFinished = true
        // Add to completed workouts (you'll need to implement this)
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
    }

    private func checkActivityCompletion() {
        if currentActivityTimeLeft <= 0 {
            if activityIndex == workoutTimeline.count - 2 {
                finishWorkout()
            } else {
                activityIndex += 1
                currentActivityTimeLeft = currentActivity.duration
            }
        }
    }

    private func updateProgress() {
        circleProgress = 1 - (currentActivityTimeLeft / currentActivity.duration)
        barProgress = (workout.duration - workoutTimeLeft) / workout.duration
    }
}
