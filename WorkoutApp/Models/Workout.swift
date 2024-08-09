//
//  Workout.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 01.08.24.
//

import Foundation

struct Workout: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    var title: String
    var cycles: Int
    var cycleRestTime: TimeInterval
    var exercises: [Exercise]
    var completions: Int
    
    var duration: TimeInterval {
        let totalExerciseTime = exercises.reduce(0) { $0 + $1.duration + $1.rest }
        let prepDuration: TimeInterval = 10
        let restLastExercise = exercises.last?.rest ?? 0
        return (Double(cycles) * totalExerciseTime) + (Double(cycles - 1) * cycleRestTime) - (Double(cycles) * restLastExercise) + prepDuration
    }
    
    init(id: UUID = UUID(), title: String, cycles: Int, cycleRestTime: TimeInterval, exercises: [Exercise], completions: Int = 0) {
        self.id = id
        self.title = title
        self.cycles = cycles
        self.cycleRestTime = cycleRestTime
        self.exercises = exercises
        self.completions = completions
    }
    
    func updateCompletion() -> Workout {
        return Workout(title: title, cycles: cycles, cycleRestTime: cycleRestTime, exercises: exercises, completions: completions)
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}

// MARK: - Sample Data

extension Workout {
    static let newWorkout = Workout(
        title: "New Workout",
        cycles: 3,
        cycleRestTime: 60,
        exercises: [
            Exercise(title: "Exercise 1", duration: 20, rest: 10),
            Exercise(title: "Exercise 2", duration: 20, rest: 10),
            Exercise(title: "Exercise 3", duration: 20, rest: 10)
        ]
    )
    
    static let sampleWorkouts: [Workout] = [
        Workout(title: "Tabata", cycles: 2, cycleRestTime: 60, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 20),
            Exercise(title: "Crunches", duration: 20, rest: 20),
            Exercise(title: "Plank", duration: 30, rest: 20)
        ], completions: 24),
        Workout(title: "Kegel", cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 20),
            Exercise(title: "Crunches", duration: 20, rest: 20),
            Exercise(title: "Plank", duration: 30, rest: 20)
        ], completions: 133),
        Workout(title: "Full Body", cycles: 17, cycleRestTime: 60, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 20),
            Exercise(title: "Crunches", duration: 20, rest: 20),
            Exercise(title: "Plank", duration: 30, rest: 20)
        ], completions: 2),
        Workout(title: "Body Core", cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 20),
            Exercise(title: "Crunches", duration: 20, rest: 20),
            Exercise(title: "Plank", duration: 30, rest: 20)
        ], completions: 4)
    ]
}
