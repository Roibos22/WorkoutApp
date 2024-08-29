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

enum WorkoutSettingsType: LocalizedStringResource {
    case exerciseDuration = "Exercise Duration"
    case exerciseRest = "Exercise Rest"
    case cycles = "Cycles"
    case cycleRest = "Cycle Rest"

    var changeValueString: LocalizedStringResource {
        switch self {
        case .exerciseDuration:
            return "Edit duration for all exercises"
        case .exerciseRest:
            return "Edit rest time for all exercises"
        case .cycles:
            return "Edit number of cycles"
        case .cycleRest:
            return "Edit rest time between cycles"
        }
    }
}
