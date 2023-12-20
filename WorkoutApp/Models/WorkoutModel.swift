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

struct Activity: Hashable, Identifiable {
    var id = UUID()
    var title: String
    var type: activityType
    var duration: Double
    var timeLeft: Double
    var startingTime: Double
    var cycleNo: Int
    var activityNo: Int
    
    enum activityType: String, Identifiable, Codable {
        case countdown
        case exercise
        case rest
        case done
        
        var name: String {
            rawValue.capitalized
        }
        
        var id: String {
            name
        }
    }
}

struct CompletedWorkout: Identifiable, Codable {
    var id = UUID()
    var workout: Workout
    var ts: Date
}

struct Cycle: Hashable {
    var title: String
    var duration: Double
    var startingTime: Double
    var activities: [Activity]
    var cycleNumber: Int
}

struct Workout: Identifiable, Codable {
    var id = UUID()
    var title: String
    var cycles: Int
    var cycleRestTime: Double
    var duration: Double
    var exercises: [Exercise]
    var completions: Int
    
    init(id: UUID = UUID(), title: String, cycles: Int, cycleRestTime: Double, exercises: [Exercise], completions: Int) {
        self.id = id
        self.title = title
        self.cycles = cycles
        self.cycleRestTime = cycleRestTime
        self.exercises = exercises
        let totalExerciseTime = exercises.reduce(0) { (total, exercise) in
            total + exercise.duration + exercise.rest
        }
        let prepDuration = 10.0
        let restLastExercise = exercises.last?.rest ?? 0.0
        self.duration = (Double(cycles) * totalExerciseTime) + (Double(cycles - 1) * cycleRestTime) - (Double(cycles) * restLastExercise) + prepDuration
        self.completions = completions
    }
    
    func updateCompletion() -> Workout {
        return Workout(title: title, cycles: cycles, cycleRestTime: cycleRestTime, exercises: exercises, completions: completions)
    }
        
}

extension Workout {
    
    static var newWorkout: Workout = Workout(title: "Workout", cycles: 3, cycleRestTime: 60, exercises: [
        Exercise(title: "Exercise 1", duration: 20, rest: 10),
        Exercise(title: "Exercise 2", duration: 20, rest: 10),
        Exercise(title: "Exercise 3", duration: 20, rest: 10)
    ], completions: 0)
    
    static var sampleWorkouts: [Workout] = [
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
        Workout(title: "Workout", cycles: 17, cycleRestTime: 60, exercises: [
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


