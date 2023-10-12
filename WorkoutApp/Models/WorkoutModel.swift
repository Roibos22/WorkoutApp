//
//  WorkoutModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.10.23.
//

import Foundation

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var title: String
    var duration: Double
    var rest: Double
}

struct Workout: Identifiable, Codable {
    var id = UUID()
    var title: String
    var cycles: Int
    var duration: Double
    var exercises: [Exercise]
    var completions: Int
    
    init(id: UUID = UUID(), title: String, cycles: Int, duration: Double, exercises: [Exercise], completions: Int) {
        self.id = id
        self.title = title
        self.cycles = cycles
        self.duration = duration
        self.exercises = exercises
        self.completions = completions
    }
    
    func updateCompletion() -> Workout {
        return Workout(title: title, cycles: cycles, duration: duration, exercises: exercises, completions: completions)
    }
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


