//
//  Language.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 30.08.24.
//
import Foundation

enum Language: String, Identifiable, Codable, Equatable {
    case englishUK = "EN_UK"
    case englishUS = "EN_US"
    case german = "DE"
    case italian = "IT"
    case french = "FR"
    case spanish = "ES"
    case portuguesePT = "PT_PT"
    case portugueseBR = "PT_BR"
    
    var id: String { self.rawValue }
    
    var locale: Locale {
        switch self {
        case .englishUK: return Locale(identifier: "en_GB")
        case .englishUS: return Locale(identifier: "en_US")
        case .german: return Locale(identifier: "de_DE")
        case .italian: return Locale(identifier: "it_IT")
        case .french: return Locale(identifier: "fr_FR")
        case .spanish: return Locale(identifier: "es_ES")
        case .portuguesePT: return Locale(identifier: "pt_PT")
        case .portugueseBR: return Locale(identifier: "pt_BR")
        }
    }
    
    var displayName: String {
        switch self {
        case .englishUK: return "🇬🇧 English (UK)"
        case .englishUS: return "🇺🇸 English (US)"
        case .german: return "🇩🇪 Deutsch"
        case .italian: return "🇮🇹 Italiano"
        case .french: return "🇫🇷 Français"
        case .spanish: return "🇪🇸 Español "
        case .portuguesePT: return "🇵🇹 Português (PT)"
        case .portugueseBR: return "🇧🇷 Português (BR)"
        }
    }
    
    var defaultWorkoutTitle: String {
        switch self {
        case .englishUK, .englishUS: return "New Workout"
        case .german: return "Neues Workout"
        case .italian: return "Nuovo Allenamento"
        case .french: return "Nouvel Entraînement"
        case .spanish: return "Nuevo Entrenamiento"
        case .portuguesePT, .portugueseBR: return "Novo Treino"
        }
    }
    
    var defaultExerciseTitle: String {
        switch self {
        case .englishUK, .englishUS: return "Exercise"
        case .german: return "Übung"
        case .italian: return "Esercizio"
        case .french: return "Exercice"
        case .spanish: return "Ejercicio"
        case .portuguesePT, .portugueseBR: return "Exercício"
        }
    }
    
    var defaultNewExerciseTitle: String {
        switch self {
        case .englishUK, .englishUS: return "New Exercise"
        case .german: return "Neue Übung"
        case .italian: return "Nuovo Esercizio"
        case .french: return "Nouvel Exercice"
        case .spanish: return "Nuevo Ejercicio"
        case .portuguesePT, .portugueseBR: return "Novo Exercício"
        }
    }
}
