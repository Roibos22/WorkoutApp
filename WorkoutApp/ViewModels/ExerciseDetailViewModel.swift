//
//  ExerciseDetailViewModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import Foundation

class ExerciseDetailViewModel: ObservableObject {
    @Published var exercise: Exercise
    private let appState: AppState
    private let workoutViewModel: WorkoutDetailViewModel

    init(exercise: Exercise, appState: AppState, workoutViewModel: WorkoutDetailViewModel) {
        self.exercise = exercise
        self.workoutViewModel = workoutViewModel
        self.appState = appState
    }
    
    func deleteExercise(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                self.appState.deleteExercise(self.exercise, from: self.workoutViewModel.workout)
                //try self.workoutViewModel.deleteExercise(self.exercise)
                print("Exercise deleted successfully")
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                print("Error deleting exercise: \(error)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }

//    func deleteExercise() {
//        // Find the index of the exercise in the workout
//        
//        if let index = workoutViewModel.workout.exercises.firstIndex(where: { $0.id == exercise.id }) {
//            // Remove the exercise from the workout
//            workoutViewModel.workout.exercises.remove(at: index)
//            
//            // Save the updated workout
//            workoutViewModel.saveWorkout()
//        }
//    }

    func updateExerciseTitle(_ title: String) {
        exercise.title = title
        updateWorkout()
    }

    func updateExerciseDuration(_ duration: Double) {
        exercise.duration = duration
        updateWorkout()
    }

    func updateExerciseRest(_ rest: Double) {
        exercise.rest = rest
        updateWorkout()
    }

    private func updateWorkout() {
        // Find the exercise in the workout and update it
        if let index = workoutViewModel.workout.exercises.firstIndex(where: { $0.id == exercise.id }) {
            workoutViewModel.workout.exercises[index] = exercise
            
            // Save the updated workout
            workoutViewModel.saveWorkout()
        }
    }
}
