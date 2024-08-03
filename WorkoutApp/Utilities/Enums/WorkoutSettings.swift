//
//  WorkoutSettingsType.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import Foundation

enum WorkoutSettingsCardFormats {
    case asMinutes
    case asNumber
}

enum WorkoutSettingsType: String {
    case exerciseDuration = "Exercise Duration"
    case exerciseRest = "Exercise Rest"
    case cycles = "Cycles"
    case cycleRest = "Cycle Rest"
}
