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
    var onDelete: () -> Void
    
    init(exercise: Exercise, workoutViewModel: WorkoutDetailViewModel, onDelete: @escaping () -> Void) {
        self.exercise = exercise
        self.workoutViewModel = workoutViewModel
        self.onDelete = onDelete
    }
    
    func deleteExercise() {
        workoutViewModel.deleteExercise(exercise)
        onDelete()
    }
}
