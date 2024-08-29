//
//  LocalizationManager.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 29.08.24.
//

import Foundation

class LocalizationManager {
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func loadLocale() -> Locale {
        return dataManager.loadLocalePreference()
    }
    
    func saveLocale(locale: Locale) {
        dataManager.saveLocalePreference(locale)
    }
}

enum Locales: String, CaseIterable, Identifiable {
    case english = "EN"
    case german = "DE"
    
    var id: String { self.rawValue }
    
    var locale: Locale {
        switch self {
        case .english:
            return Locale(identifier: "en_US")
        case .german:
            return Locale(identifier: "de_DE")
        }
    }
    
    var displayName: String {
        switch self {
        case .english:
            return "English"
        case .german:
            return "Deutsch"
        }
    }
}
