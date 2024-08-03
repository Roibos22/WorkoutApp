//
//  WorkoutDetailViewModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import Foundation

class WorkoutDetailViewModel: ObservableObject {
    @Published var workout: Workout
    @Published var completions: Int = 0
    private let appState: AppState
    let isNewWorkout: Bool

    init(workout: Workout? = nil, appState: AppState) {
        self.appState = appState
        self.isNewWorkout = workout == nil
        self.workout = workout ?? appState.generateNewWorkout()
        updateCompletions()
    }
    
    func updateCompletions() {
        completions = appState.completedWorkouts.filter { $0.workout.title == workout.title }.count
    }

    func saveWorkout() {
        print("call saveWorkout AS from saveWorkout VM")
        appState.saveWorkout(workout)
//        if isNewWorkout {
//            //appState.addWorkout(workout)
//        } else {
//            //appState.updateWorkout(workout)
//        }
    }

    func deleteWorkout() {
        appState.deleteWorkout(workout)
    }

    func updateTitle(_ title: String) {
        workout.title = title
        print("call saveWorkout VM from updateTitle in View")
        saveWorkout()
    }
}
