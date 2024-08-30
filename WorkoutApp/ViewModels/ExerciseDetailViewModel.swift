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
    
    init(exercise: Exercise? = nil, workoutViewModel: WorkoutDetailViewModel) {
        let language: Language = Language(rawValue: UserDefaults.standard.string(forKey: "AppLanguage") ?? "EN") ?? .english
        self.exercise = exercise ?? Exercise(title: "\(language.defaultNewExerciseTitle)", duration: 20, rest: 10)
        self.workoutViewModel = workoutViewModel
    }
    
    func deleteExercise() {
        workoutViewModel.deleteExercise(exercise)
    }
    
    func addExercise() {
        workoutViewModel.addExercise(exercise)
    }
    
    func updateExercise() {
        if let index = workoutViewModel.workout.exercises.firstIndex(where: { $0.id == exercise.id }) {
            workoutViewModel.workout.exercises[index] = exercise
        }
    }
    
    func saveExercise() {
        if workoutViewModel.workout.exercises.contains(where: { $0.id == exercise.id }) {
            updateExercise()
        } else {
            addExercise()
        }
    }
    
    func getExercisesCount() -> Int {
        return workoutViewModel.workout.exercises.count
    }
    
}
