//
//  ActivityAttributes.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 31.08.24.
//

import Foundation
import ActivityKit

struct WorkoutAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var elapsedTime: TimeInterval
        var currentExercise: String
    }
    
    var workoutName: String
}
