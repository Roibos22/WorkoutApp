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
    
    func duplicatWithNewId() -> Workout {
        return Workout(id: UUID(), title: self.title, cycles: self.cycles, cycleRestTime: self.cycleRestTime, exercises: self.exercises)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

// MARK: - Sample Data

extension Workout {
    static let newWorkout = Workout(
        title: String("New Workout"),
        cycles: 3,
        cycleRestTime: 60,
        exercises: [
            Exercise(title: String("Exercise 1"), duration: 20, rest: 10),
            Exercise(title: String("Exercise 2"), duration: 20, rest: 10),
            Exercise(title: String("Exercise 3"), duration: 20, rest: 10)
        ]
    )

    static let defaultWorkouts: [Workout] = [
        Workout(title: String("My Workout"), cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: String("Exercise 1"), duration: 30, rest: 15),
            Exercise(title: String("Exercise 2"), duration: 30, rest: 15),
            Exercise(title: String("Exercise 3"), duration: 30, rest: 15),
            Exercise(title: String("Exercise 4"), duration: 30, rest: 15)
        ], completions: 0)
    ]

    static let sampleWorkouts: [Workout] = [
        Workout(title: String("Classic Tabata"), cycles: 2, cycleRestTime: 10, exercises: [
            Exercise(title: String("Burpee"), duration: 20, rest: 10),
            Exercise(title: String("Push-ups"), duration: 20, rest: 10),
            Exercise(title: String("Jumping Jacks"), duration: 20, rest: 10),
            Exercise(title: String("Squats"), duration: 20, rest: 10)
        ], completions: 0),

        Workout(title: String("Tabata Turbo"), cycles: 3, cycleRestTime: 10, exercises: [
            Exercise(title: String("Burpees"), duration: 20, rest: 10),
            Exercise(title: String("Push-ups"), duration: 20, rest: 10),
            Exercise(title: String("Jump Lunges"), duration: 20, rest: 10),
            Exercise(title: String("Mountain Climbers"), duration: 20, rest: 10),
            Exercise(title: String("Squats"), duration: 20, rest: 10),
            Exercise(title: String("Jumping Jacks"), duration: 20, rest: 10)
        ], completions: 0),

        Workout(title: String("HIIT Cardio Blast"), cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: String("High Knees"), duration: 30, rest: 15),
            Exercise(title: String("Burpees"), duration: 30, rest: 15),
            Exercise(title: String("Mountain Climbers"), duration: 30, rest: 15),
            Exercise(title: String("Jump Squats"), duration: 30, rest: 15),
            Exercise(title: String("Jumping Jacks"), duration: 30, rest: 15)
        ], completions: 0),

        Workout(title: String("Core Crusher"), cycles: 3, cycleRestTime: 45, exercises: [
            Exercise(title: String("Plank"), duration: 45, rest: 15),
            Exercise(title: String("Russian Twists"), duration: 30, rest: 15),
            Exercise(title: String("Bicycle Crunches"), duration: 30, rest: 15),
            Exercise(title: String("Leg Raises"), duration: 30, rest: 15),
            Exercise(title: String("Mountain Climbers"), duration: 30, rest: 15)
        ], completions: 0),

        Workout(title: String("Upper Body Blitz"), cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: String("Push-ups"), duration: 40, rest: 20),
            Exercise(title: String("Tricep Dips"), duration: 40, rest: 20),
            Exercise(title: String("Diamond Push-ups"), duration: 30, rest: 20),
            Exercise(title: String("Arm Circles"), duration: 30, rest: 20),
            Exercise(title: String("Wall Push-ups"), duration: 40, rest: 20)
        ], completions: 0),

        Workout(title: String("Lower Body Burner"), cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: String("Squats"), duration: 45, rest: 15),
            Exercise(title: String("Lunges"), duration: 45, rest: 15),
            Exercise(title: String("Calf Raises"), duration: 30, rest: 15),
            Exercise(title: String("Glute Bridges"), duration: 45, rest: 15),
            Exercise(title: String("Wall Sit"), duration: 30, rest: 15)
        ], completions: 0),

        Workout(title: String("Full Body Fusion"), cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: String("Burpees"), duration: 30, rest: 15),
            Exercise(title: String("Push-ups"), duration: 30, rest: 15),
            Exercise(title: String("Squats"), duration: 30, rest: 15),
            Exercise(title: String("Mountain Climbers"), duration: 30, rest: 15),
            Exercise(title: String("Plank"), duration: 30, rest: 15)
        ], completions: 0),

        Workout(title: String("Cardio Kickstart"), cycles: 3, cycleRestTime: 45, exercises: [
            Exercise(title: String("Jumping Jacks"), duration: 45, rest: 15),
            Exercise(title: String("High Knees"), duration: 45, rest: 15),
            Exercise(title: String("Butt Kicks"), duration: 45, rest: 15),
            Exercise(title: String("Mountain Climbers"), duration: 45, rest: 15),
            Exercise(title: String("Squat Jumps"), duration: 45, rest: 15)
        ], completions: 0),

        Workout(title: String("Strength Endurance"), cycles: 3, cycleRestTime: 90, exercises: [
            Exercise(title: String("Push-ups"), duration: 60, rest: 30),
            Exercise(title: String("Squats"), duration: 60, rest: 30),
            Exercise(title: String("Plank"), duration: 60, rest: 30),
            Exercise(title: String("Lunges"), duration: 60, rest: 30),
            Exercise(title: String("Wall Sit"), duration: 60, rest: 30)
        ], completions: 0),

        Workout(title: String("Plyometric Power"), cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: String("Box Jumps"), duration: 30, rest: 20),
            Exercise(title: String("Burpees"), duration: 30, rest: 20),
            Exercise(title: String("Jump Lunges"), duration: 30, rest: 20),
            Exercise(title: String("Tuck Jumps"), duration: 30, rest: 20),
            Exercise(title: String("Plyo Push-ups"), duration: 30, rest: 20)
        ], completions: 0),

        Workout(title: String("Bodyweight Bootcamp"), cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: String("Push-ups"), duration: 40, rest: 20),
            Exercise(title: String("Squats"), duration: 40, rest: 20),
            Exercise(title: String("Dips"), duration: 40, rest: 20),
            Exercise(title: String("Lunges"), duration: 40, rest: 20),
            Exercise(title: String("Plank"), duration: 40, rest: 20),
            Exercise(title: String("Mountain Climbers"), duration: 40, rest: 20)
        ], completions: 0),

        Workout(title: String("Core Stability Flow"), cycles: 3, cycleRestTime: 45, exercises: [
            Exercise(title: String("Plank"), duration: 45, rest: 15),
            Exercise(title: String("Side Plank (Left)"), duration: 30, rest: 15),
            Exercise(title: String("Side Plank (Right)"), duration: 30, rest: 15),
            Exercise(title: String("Bird Dog"), duration: 45, rest: 15),
            Exercise(title: String("Superman"), duration: 30, rest: 15)
        ], completions: 0),

        Workout(title: String("Cardio-Strength Fusion"), cycles: 4, cycleRestTime: 60, exercises: [
            Exercise(title: String("Burpees"), duration: 30, rest: 15),
            Exercise(title: String("Push-ups"), duration: 30, rest: 15),
            Exercise(title: String("Jump Squats"), duration: 30, rest: 15),
            Exercise(title: String("Mountain Climbers"), duration: 30, rest: 15),
            Exercise(title: String("Plank Jacks"), duration: 30, rest: 15)
        ], completions: 0),

        Workout(title: String("Flexibility and Mobility"), cycles: 2, cycleRestTime: 30, exercises: [
            Exercise(title: String("Arm Circles"), duration: 30, rest: 10),
            Exercise(title: String("Leg Swings"), duration: 30, rest: 10),
            Exercise(title: String("Torso Twists"), duration: 30, rest: 10),
            Exercise(title: String("Hip Circles"), duration: 30, rest: 10),
            Exercise(title: String("Cat-Cow Stretch"), duration: 30, rest: 10),
            Exercise(title: String("Downward Dog"), duration: 30, rest: 10)
        ], completions: 0),

        Workout(title: String("Metabolic Booster"), cycles: 5, cycleRestTime: 60, exercises: [
            Exercise(title: String("Jump Rope"), duration: 30, rest: 15),
            Exercise(title: String("Squat Thrusts"), duration: 30, rest: 15),
            Exercise(title: String("Mountain Climbers"), duration: 30, rest: 15),
            Exercise(title: String("Burpees"), duration: 30, rest: 15)
        ], completions: 0),

        Workout(title: String("Functional Fitness"), cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: String("Kettlebell Swings"), duration: 40, rest: 20),
            Exercise(title: String("Push-ups"), duration: 40, rest: 20),
            Exercise(title: String("Goblet Squats"), duration: 40, rest: 20),
            Exercise(title: String("Renegade Rows"), duration: 40, rest: 20),
            Exercise(title: String("Plank"), duration: 40, rest: 20)
        ], completions: 0),

        Workout(title: String("Endurance Builder"), cycles: 2, cycleRestTime: 120, exercises: [
            Exercise(title: String("Jump Rope"), duration: 90, rest: 30),
            Exercise(title: String("Mountain Climbers"), duration: 90, rest: 30),
            Exercise(title: String("High Knees"), duration: 90, rest: 30),
            Exercise(title: String("Burpees"), duration: 90, rest: 30)
        ], completions: 0),

        Workout(title: String("Power Yoga Flow"), cycles: 3, cycleRestTime: 30, exercises: [
            Exercise(title: String("Sun Salutation A"), duration: 60, rest: 15),
            Exercise(title: String("Warrior I"), duration: 45, rest: 15),
            Exercise(title: String("Warrior II"), duration: 45, rest: 15),
            Exercise(title: String("Chair Pose"), duration: 30, rest: 15),
            Exercise(title: String("Plank"), duration: 30, rest: 15)
        ], completions: 0),

        Workout(title: String("Sprint Intervals"), cycles: 6, cycleRestTime: 90, exercises: [
            Exercise(title: String("Sprint"), duration: 20, rest: 40),
            Exercise(title: String("Jog"), duration: 40, rest: 20),
            Exercise(title: String("Sprint"), duration: 20, rest: 40),
            Exercise(title: String("Walk"), duration: 30, rest: 30)
        ], completions: 0),

        Workout(title: String("Pilates Core Sculpt"), cycles: 2, cycleRestTime: 60, exercises: [
            Exercise(title: String("The Hundred"), duration: 60, rest: 30),
            Exercise(title: String("Roll Up"), duration: 45, rest: 30),
            Exercise(title: String("Single Leg Circles"), duration: 60, rest: 30),
            Exercise(title: String("Double Leg Stretch"), duration: 45, rest: 30),
            Exercise(title: String("Criss-Cross"), duration: 45, rest: 30),
            Exercise(title: String("Teaser"), duration: 45, rest: 30)
        ], completions: 0),

        Workout(title: String("Dumbbell Total Body"), cycles: 3, cycleRestTime: 60, exercises: [
            Exercise(title: String("Dumbbell Squats"), duration: 40, rest: 20),
            Exercise(title: String("Dumbbell Rows"), duration: 40, rest: 20),
            Exercise(title: String("Dumbbell Chest Press"), duration: 40, rest: 20),
            Exercise(title: String("Dumbbell Lunges"), duration: 40, rest: 20),
            Exercise(title: String("Dumbbell Shoulder Press"), duration: 40, rest: 20)
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
