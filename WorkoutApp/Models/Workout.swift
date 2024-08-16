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
    
    static let defaultWorkouts: [Workout] = [
        Workout(title: "My Workout", cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: "Exercise 1", duration: 30, rest: 15),
            Exercise(title: "Exercise 2", duration: 30, rest: 15),
            Exercise(title: "Exercise 3", duration: 30, rest: 15),
            Exercise(title: "Exercise 4", duration: 30, rest: 15)
        ], completions: 0)
    ]
    
    static let sampleWorkouts: [Workout] = [
        Workout(title: "Classic Tabata", cycles: 2, cycleRestTime: 10, exercises: [
            Exercise(title: "Burpee", duration: 20, rest: 10),
            Exercise(title: "Push-ups", duration: 20, rest: 10),
            Exercise(title: "Jumping Jacks", duration: 20, rest: 10),
            Exercise(title: "Squats", duration: 20, rest: 10)
        ], completions: 0),
        
        Workout(title: "Tabata Turbo", cycles: 3, cycleRestTime: 10, exercises: [
            Exercise(title: "Burpees", duration: 20, rest: 10),
            Exercise(title: "Push-ups", duration: 20, rest: 10),
            Exercise(title: "Jump Lunges", duration: 20, rest: 10),
            Exercise(title: "Mountain Climbers", duration: 20, rest: 10),
            Exercise(title: "Squats", duration: 20, rest: 10),
            Exercise(title: "Jumping Jacks", duration: 20, rest: 10)
        ], completions: 0),
        
        Workout(title: "HIIT Cardio Blast", cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: "High Knees", duration: 30, rest: 15),
            Exercise(title: "Burpees", duration: 30, rest: 15),
            Exercise(title: "Mountain Climbers", duration: 30, rest: 15),
            Exercise(title: "Jump Squats", duration: 30, rest: 15),
            Exercise(title: "Jumping Jacks", duration: 30, rest: 15)
        ], completions: 0),
        
        Workout(title: "Core Crusher", cycles: 3, cycleRestTime: 45, exercises: [
            Exercise(title: "Plank", duration: 45, rest: 15),
            Exercise(title: "Russian Twists", duration: 30, rest: 15),
            Exercise(title: "Bicycle Crunches", duration: 30, rest: 15),
            Exercise(title: "Leg Raises", duration: 30, rest: 15),
            Exercise(title: "Mountain Climbers", duration: 30, rest: 15)
        ], completions: 0),
        
        Workout(title: "Upper Body Blitz", cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: "Push-ups", duration: 40, rest: 20),
            Exercise(title: "Tricep Dips", duration: 40, rest: 20),
            Exercise(title: "Diamond Push-ups", duration: 30, rest: 20),
            Exercise(title: "Arm Circles", duration: 30, rest: 20),
            Exercise(title: "Wall Push-ups", duration: 40, rest: 20)
        ], completions: 0),
        
        Workout(title: "Lower Body Burner", cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: "Squats", duration: 45, rest: 15),
            Exercise(title: "Lunges", duration: 45, rest: 15),
            Exercise(title: "Calf Raises", duration: 30, rest: 15),
            Exercise(title: "Glute Bridges", duration: 45, rest: 15),
            Exercise(title: "Wall Sit", duration: 30, rest: 15)
        ], completions: 0),
        
        Workout(title: "Full Body Fusion", cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: "Burpees", duration: 30, rest: 15),
            Exercise(title: "Push-ups", duration: 30, rest: 15),
            Exercise(title: "Squats", duration: 30, rest: 15),
            Exercise(title: "Mountain Climbers", duration: 30, rest: 15),
            Exercise(title: "Plank", duration: 30, rest: 15)
        ], completions: 0),
        
        Workout(title: "Cardio Kickstart", cycles: 3, cycleRestTime: 45, exercises: [
            Exercise(title: "Jumping Jacks", duration: 45, rest: 15),
            Exercise(title: "High Knees", duration: 45, rest: 15),
            Exercise(title: "Butt Kicks", duration: 45, rest: 15),
            Exercise(title: "Mountain Climbers", duration: 45, rest: 15),
            Exercise(title: "Squat Jumps", duration: 45, rest: 15)
        ], completions: 0),
        
        Workout(title: "Strength Endurance", cycles: 3, cycleRestTime: 90, exercises: [
            Exercise(title: "Push-ups", duration: 60, rest: 30),
            Exercise(title: "Squats", duration: 60, rest: 30),
            Exercise(title: "Plank", duration: 60, rest: 30),
            Exercise(title: "Lunges", duration: 60, rest: 30),
            Exercise(title: "Wall Sit", duration: 60, rest: 30)
        ], completions: 0),
        
        Workout(title: "Plyometric Power", cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: "Box Jumps", duration: 30, rest: 20),
            Exercise(title: "Burpees", duration: 30, rest: 20),
            Exercise(title: "Jump Lunges", duration: 30, rest: 20),
            Exercise(title: "Tuck Jumps", duration: 30, rest: 20),
            Exercise(title: "Plyo Push-ups", duration: 30, rest: 20)
        ], completions: 0),
        
        Workout(title: "Bodyweight Bootcamp", cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: "Push-ups", duration: 40, rest: 20),
            Exercise(title: "Squats", duration: 40, rest: 20),
            Exercise(title: "Dips", duration: 40, rest: 20),
            Exercise(title: "Lunges", duration: 40, rest: 20),
            Exercise(title: "Plank", duration: 40, rest: 20),
            Exercise(title: "Mountain Climbers", duration: 40, rest: 20)
        ], completions: 0),
        
        Workout(title: "Core Stability Flow", cycles: 3, cycleRestTime: 45, exercises: [
            Exercise(title: "Plank", duration: 45, rest: 15),
            Exercise(title: "Side Plank (Left)", duration: 30, rest: 15),
            Exercise(title: "Side Plank (Right)", duration: 30, rest: 15),
            Exercise(title: "Bird Dog", duration: 45, rest: 15),
            Exercise(title: "Superman", duration: 30, rest: 15)
        ], completions: 0),
        
        Workout(title: "Cardio-Strength Fusion", cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: "Burpees", duration: 30, rest: 15),
            Exercise(title: "Push-ups", duration: 30, rest: 15),
            Exercise(title: "Jump Squats", duration: 30, rest: 15),
            Exercise(title: "Mountain Climbers", duration: 30, rest: 15),
            Exercise(title: "Plank Jacks", duration: 30, rest: 15)
        ], completions: 0),
        
        Workout(title: "Flexibility and Mobility", cycles: 2, cycleRestTime: 30, exercises: [
            Exercise(title: "Arm Circles", duration: 30, rest: 10),
            Exercise(title: "Leg Swings", duration: 30, rest: 10),
            Exercise(title: "Torso Twists", duration: 30, rest: 10),
            Exercise(title: "Hip Circles", duration: 30, rest: 10),
            Exercise(title: "Cat-Cow Stretch", duration: 30, rest: 10),
            Exercise(title: "Downward Dog", duration: 30, rest: 10)
        ], completions: 0),
        
        Workout(title: "Metabolic Booster", cycles: 5, cycleRestTime: 60, exercises: [
            Exercise(title: "Jump Rope", duration: 30, rest: 15),
            Exercise(title: "Squat Thrusts", duration: 30, rest: 15),
            Exercise(title: "Mountain Climbers", duration: 30, rest: 15),
            Exercise(title: "Burpees", duration: 30, rest: 15)
        ], completions: 0),
        
        Workout(title: "Functional Fitness", cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: "Kettlebell Swings", duration: 40, rest: 20),
            Exercise(title: "Push-ups", duration: 40, rest: 20),
            Exercise(title: "Goblet Squats", duration: 40, rest: 20),
            Exercise(title: "Renegade Rows", duration: 40, rest: 20),
            Exercise(title: "Plank", duration: 40, rest: 20)
        ], completions: 0),
        
        Workout(title: "Endurance Builder", cycles: 2, cycleRestTime: 120, exercises: [
            Exercise(title: "Jump Rope", duration: 90, rest: 30),
            Exercise(title: "Mountain Climbers", duration: 90, rest: 30),
            Exercise(title: "High Knees", duration: 90, rest: 30),
            Exercise(title: "Burpees", duration: 90, rest: 30)
        ], completions: 0),
        
        Workout(title: "Power Yoga Flow", cycles: 3, cycleRestTime: 30, exercises: [
            Exercise(title: "Sun Salutation A", duration: 60, rest: 15),
            Exercise(title: "Warrior I", duration: 45, rest: 15),
            Exercise(title: "Warrior II", duration: 45, rest: 15),
            Exercise(title: "Chair Pose", duration: 30, rest: 15),
            Exercise(title: "Plank", duration: 30, rest: 15)
        ], completions: 0),
        
        Workout(title: "Sprint Intervals", cycles: 6, cycleRestTime: 90, exercises: [
            Exercise(title: "Sprint", duration: 20, rest: 40),
            Exercise(title: "Jog", duration: 40, rest: 20),
            Exercise(title: "Sprint", duration: 20, rest: 40),
            Exercise(title: "Walk", duration: 30, rest: 30)
        ], completions: 0),
        
        Workout(title: "Pilates Core Sculpt", cycles: 2, cycleRestTime: 60, exercises: [
            Exercise(title: "The Hundred", duration: 60, rest: 30),
            Exercise(title: "Roll Up", duration: 45, rest: 30),
            Exercise(title: "Single Leg Circles", duration: 60, rest: 30),
            Exercise(title: "Double Leg Stretch", duration: 45, rest: 30),
            Exercise(title: "Criss-Cross", duration: 45, rest: 30),
            Exercise(title: "Teaser", duration: 45, rest: 30)
        ], completions: 0),
        
        Workout(title: "Dumbbell Total Body", cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: "Dumbbell Squats", duration: 40, rest: 20),
            Exercise(title: "Dumbbell Rows", duration: 40, rest: 20),
            Exercise(title: "Dumbbell Chest Press", duration: 40, rest: 20),
            Exercise(title: "Dumbbell Lunges", duration: 40, rest: 20),
            Exercise(title: "Dumbbell Shoulder Press", duration: 40, rest: 20)
        ], completions: 0)
    ]
    
    static let sampleWorkoutHistory: [CompletedWorkout] = [
        // 1 day ago
        CompletedWorkout(
            workout: defaultWorkouts[2],
            timestamp: Date().addingTimeInterval(-1 * 24 * 60 * 60 - (1500))
        ),
        CompletedWorkout(
            workout: defaultWorkouts[0],
            timestamp: Date().addingTimeInterval(-1 * 24 * 60 * 60)
        ),
        
        // 2 day ago
        CompletedWorkout(
            workout: defaultWorkouts[2],
            timestamp: Date().addingTimeInterval(-2 * 24 * 60 * 60 - (1500))
        ),
        
        // 3 day ago
        CompletedWorkout(
            workout: defaultWorkouts[2],
            timestamp: Date().addingTimeInterval(-3 * 24 * 60 * 60 - (1500))
        ),
        CompletedWorkout(
            workout: defaultWorkouts[1],
            timestamp: Date().addingTimeInterval(-3 * 24 * 60 * 60)
        ),
        
        // 4 day ago
        CompletedWorkout(
            workout: defaultWorkouts[2],
            timestamp: Date().addingTimeInterval(-4 * 24 * 60 * 60 - (1500))
        ),
        
        // 5 day ago
        CompletedWorkout(
            workout: defaultWorkouts[2],
            timestamp: Date().addingTimeInterval(-5 * 24 * 60 * 60 - (1500))
        ),
        CompletedWorkout(
            workout: defaultWorkouts[0],
            timestamp: Date().addingTimeInterval(-5 * 24 * 60 * 60)
        )

    ]
}
