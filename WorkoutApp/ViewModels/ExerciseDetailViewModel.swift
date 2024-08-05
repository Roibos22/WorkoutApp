//
//  ExerciseDetailViewModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.08.24.
//

import Foundation

class ExerciseDetailViewModel: ObservableObject {
    @Published var exercise: Exercise
    private let workoutViewModel: WorkoutDetailViewModel
    
    init(exercise: Exercise, workoutViewModel: WorkoutDetailViewModel) {
        self.exercise = exercise
        self.workoutViewModel = workoutViewModel
    }
    
    func deleteExercise() {
        workoutViewModel.deleteExercise(exercise)
    }
}
