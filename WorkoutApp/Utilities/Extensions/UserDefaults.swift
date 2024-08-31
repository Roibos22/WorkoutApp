//
//  UserDefaults'.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 01.09.24.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let hasCreatedCustomWorkout = "hasCreatedCustomWorkout"
        static let hasSavedTemplateWorkout = "hasSavedTemplateWorkout"
        static let hasSoundsEnabled = "hasSoundsEnabled"
    }
    
    var hasSoundsEnabled: Bool {
        get { bool(forKey: Keys.hasSoundsEnabled) }
        set { set(newValue, forKey: Keys.hasSoundsEnabled) }
    }
    
    var hasCreatedCustomWorkout: Bool {
        get { bool(forKey: Keys.hasCreatedCustomWorkout) }
        set { set(newValue, forKey: Keys.hasCreatedCustomWorkout) }
    }
    
    var hasSavedTemplateWorkout: Bool {
        get { bool(forKey: Keys.hasSavedTemplateWorkout) }
        set { set(newValue, forKey: Keys.hasSavedTemplateWorkout) }
    }
}
