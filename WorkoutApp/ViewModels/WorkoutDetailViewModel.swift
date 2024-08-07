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
    
    func deleteExercise(_ exercise: Exercise) {
        workout.exercises.removeAll { $0.id == exercise.id }
        saveWorkout(notifyObservers: false)
    }
    
    func deleteExerciseIndexSet(at offsets: IndexSet) {
        workout.exercises.remove(atOffsets: offsets)
        saveWorkout(notifyObservers: false)
    }
    
    func addExercise(_ exercise: Exercise) {
//        var exercise = Exercise(title: "New", duration: 20, rest: 10)
        //workout.exercises.removeAll { $0.id == exercise.id }
        workout.exercises.append(exercise)
        saveWorkout(notifyObservers: false)
    }
    
    func moveExercise(at offsets: IndexSet, to destination: Int) {
        //appState.moveExercise(workout: workout, at: offsets, to: destination)
        workout.exercises.move(fromOffsets: offsets, toOffset: destination)
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
