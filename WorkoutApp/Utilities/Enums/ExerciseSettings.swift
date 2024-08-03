//
//  ExerciseSettings.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import Foundation

enum ExerciseSettingsType: String {
    case exerciseDuration = "Exercise Duration"
    case exerciseRest = "Exercise Rest"

    var changeValueString: String {
        switch self {
        case .exerciseDuration:
            return "Edit exercise duration"
        case .exerciseRest:
            return "Edit exercise rest time"
        }
    }
    
    var icon: String {
        switch self {
        case .exerciseDuration:
            return "stopwatch"
        case .exerciseRest:
            return "hourglass"
        }
    }
}
