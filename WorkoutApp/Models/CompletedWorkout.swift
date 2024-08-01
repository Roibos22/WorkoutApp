//
//  CompletedWorkout.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 01.08.24.
//

import Foundation

struct CompletedWorkout: Identifiable, Codable {
    let id: UUID
    let workout: Workout
    let timestamp: Date
    
    init(id: UUID = UUID(), workout: Workout, timestamp: Date = Date()) {
        self.id = id
        self.workout = workout
        self.timestamp = timestamp
    }
}
