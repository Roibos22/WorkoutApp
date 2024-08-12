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
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.cycles == rhs.cycles &&
        lhs.cycleRestTime == rhs.cycleRestTime &&
        lhs.exercises == rhs.exercises &&
        lhs.completions == rhs.completions
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
        Workout(title: "HIIT Cardio", cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: "High Knees", duration: 30, rest: 15),
            Exercise(title: "Burpees", duration: 30, rest: 15),
            Exercise(title: "Mountain Climbers", duration: 30, rest: 15),
            Exercise(title: "Jump Squats", duration: 30, rest: 15)
        ], completions: 0),
        Workout(title: "Body Core Crusher", cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: "Crunches", duration: 40, rest: 20),
            Exercise(title: "Push-ups", duration: 40, rest: 20),
            Exercise(title: "Twists", duration: 40, rest: 20),
            Exercise(title: "Leg Raises", duration: 40, rest: 20),
            Exercise(title: "Plank Hold", duration: 40, rest: 20)
        ], completions: 0),
        Workout(title: "Tabata Challenge", cycles: 8, cycleRestTime: 20, exercises: [
            Exercise(title: "Squat Jumps", duration: 20, rest: 10),
            Exercise(title: "Push-ups", duration: 20, rest: 10),
            Exercise(title: "Mountain Climbers", duration: 20, rest: 10),
            Exercise(title: "Plank Jacks", duration: 20, rest: 10)
        ], completions: 0)
    ]
    
    static let sampleWorkoutHistory: [CompletedWorkout] = [
        // 1 day ago
        CompletedWorkout(
            workout: sampleWorkouts[2],
            timestamp: Date().addingTimeInterval(-1 * 24 * 60 * 60 - (1500))
        ),
        CompletedWorkout(
            workout: sampleWorkouts[0],
            timestamp: Date().addingTimeInterval(-1 * 24 * 60 * 60)
        ),
        
        // 2 day ago
        CompletedWorkout(
            workout: sampleWorkouts[2],
            timestamp: Date().addingTimeInterval(-2 * 24 * 60 * 60 - (1500))
        ),
        
        // 3 day ago
        CompletedWorkout(
            workout: sampleWorkouts[2],
            timestamp: Date().addingTimeInterval(-3 * 24 * 60 * 60 - (1500))
        ),
        CompletedWorkout(
            workout: sampleWorkouts[1],
            timestamp: Date().addingTimeInterval(-3 * 24 * 60 * 60)
        ),
        
        // 4 day ago
        CompletedWorkout(
            workout: sampleWorkouts[2],
            timestamp: Date().addingTimeInterval(-4 * 24 * 60 * 60 - (1500))
        ),
        
        // 5 day ago
        CompletedWorkout(
            workout: sampleWorkouts[2],
            timestamp: Date().addingTimeInterval(-5 * 24 * 60 * 60 - (1500))
        ),
        CompletedWorkout(
            workout: sampleWorkouts[0],
            timestamp: Date().addingTimeInterval(-5 * 24 * 60 * 60)
        )

    ]
}
