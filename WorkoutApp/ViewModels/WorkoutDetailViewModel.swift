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

    func saveWorkout(notifyObservers: Bool = false) {
        print("call saveWorkout AS from saveWorkout VM")
        appState.saveWorkout(workout, notifyObservers: notifyObservers)
    }
    
//    func saveWorkoutLocally() {
//        print("SavingLocally")
//        appState.saveWorkout(workout)
//    }
//
//    func finalSaveWorkout() {
//        print("SavingFinal")
//        appState.saveWorkout(workout)
//    }
//    
//    func deleteExercise(_ exercise: Exercise) {
//        workout.exercises.removeAll { $0.id == exercise.id }
//        saveWorkout()
//        objectWillChange.send()
//    }

    func deleteExercise(_ exercise: Exercise) {
        workout.exercises.removeAll { $0.id == exercise.id }
        saveWorkout(notifyObservers: false)
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
