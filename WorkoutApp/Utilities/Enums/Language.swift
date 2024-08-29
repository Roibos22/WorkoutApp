//
//  Language.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 30.08.24.
//

import Foundation

enum Language: String, Identifiable, Codable, Equatable {
    case english = "EN"
    case german = "DE"
    
    var id: String { self.rawValue }
    
    var locale: Locale {
        switch self {
        case .english: return Locale(identifier: "en")
        case .german: return Locale(identifier: "de")
        }
    }
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .german: return "Deutsch"
        }
    }
}
