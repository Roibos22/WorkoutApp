//
//  CompletedWorkout.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 01.08.24.
//

import Foundation

struct CompletedWorkout: Identifiable, Codable {
    var id: UUID
    var workout: Workout
    var timestamp: Date
    
    init(id: UUID = UUID(), workout: Workout, timestamp: Date = Date()) {
        self.id = id
        self.workout = workout
        self.timestamp = timestamp
    }
}

struct WorkoutGroup: Identifiable {
    let id = UUID()
    let date: Date
    let workouts: [CompletedWorkout]
}

