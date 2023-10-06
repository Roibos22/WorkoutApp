//
//  WorkoutModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.10.23.
//

import Foundation

struct Exercise: Identifiable {
    let id = UUID()
    var title: String
    var duration: Double
    var rest: Double
}

struct Workout: Identifiable {
    let id = UUID()
    var title: String
    var cycles: Int
    var duration: Double
    var exercises: [Exercise]
    var completions: Int
}

extension Workout {
    static var sampleWorkouts: [Workout] = [
        Workout(title: "Tabata", cycles: 2, duration: 1060, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 20),
            Exercise(title: "Crunches", duration: 20, rest: 20),
            Exercise(title: "Plank", duration: 30, rest: 20)
        ], completions: 24),
        Workout(title: "Kegel", cycles: 3, duration: 500, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 20),
            Exercise(title: "Crunches", duration: 20, rest: 20),
            Exercise(title: "Plank", duration: 30, rest: 20)
        ], completions: 133),
        Workout(title: "Workout", cycles: 17, duration: 3000, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 20),
            Exercise(title: "Crunches", duration: 20, rest: 20),
            Exercise(title: "Plank", duration: 30, rest: 20)
        ], completions: 2),
        Workout(title: "Body Core", cycles: 4, duration: 2500, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 20),
            Exercise(title: "Crunches", duration: 20, rest: 20),
            Exercise(title: "Plank", duration: 30, rest: 20)
        ], completions: 4)
    ]
}
