//
//  Achievement.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 17.08.24.
//

import Foundation
import SwiftUI

struct AchievementGroup: Identifiable, Codable {
    var id = UUID()
    var title: String
    var achievements: [Achievement]
}

struct Achievement: Identifiable, Codable {
    var id = UUID()
    var title: String
    var caption: String
    var icon: String
    var iconColor: String  // Store color as a string
    var achieved: Bool
    
    // Computed property to convert string to Color
    var color: Color {
        Color(hex: iconColor)
    }
    
    init(id: UUID = UUID(), title: String, caption: String, icon: String, iconColor: Color, achieved: Bool) {
        self.id = id
        self.title = title
        self.caption = caption
        self.icon = icon
        self.iconColor = iconColor.toHex() ?? "#000000"
        self.achieved = achieved
    }
}

// Extension to convert Color to hex string and back
extension Color {
    func toHex() -> String? {
        guard let components = UIColor(self).cgColor.components else { return nil }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Achievement {
    
    static let achievements: [AchievementGroup] = [
        AchievementGroup(title: "Streaks", achievements: streakAchievements),
        AchievementGroup(title: "Completions", achievements: completionAchievements),
        AchievementGroup(title: "Duration", achievements: durationAchievements),
        AchievementGroup(title: "More", achievements: miscAchievements)
    ]
    
    static let streakAchievements = [
        Achievement(title: "Newbie", caption: "Work out for 1 day", icon: "figure.walk", iconColor: .blue, achieved: false),
        Achievement(title: "Starter", caption: "3-day workout streak", icon: "stopwatch.fill", iconColor: .cyan, achieved: false),
        Achievement(title: "Weekly", caption: "7-day workout streak", icon: "calendar", iconColor: .teal, achieved: false),
        Achievement(title: "Fortnight", caption: "14-day workout streak", icon: "flame.fill", iconColor: .green, achieved: false),
        Achievement(title: "Monthly", caption: "30-day workout streak", icon: "moon.stars.fill", iconColor: .yellow, achieved: false),
        Achievement(title: "Champion", caption: "90-day workout streak", icon: "trophy.fill", iconColor: .orange, achieved: false)
    ]

    static let completionAchievements = [
        Achievement(title: "Newbie", caption: "Complete 1 workout", icon: "leaf.fill", iconColor: .blue, achieved: false),
        Achievement(title: "Starter", caption: "Complete 5 workouts", icon: "checkmark.circle.fill", iconColor: .cyan, achieved: false),
        Achievement(title: "Consistent", caption: "Complete 15 workouts", icon: "figure.walk", iconColor: .teal, achieved: false),
        Achievement(title: "Dedicated", caption: "Complete 30 workouts", icon: "dumbbell.fill", iconColor: .green, achieved: false),
        Achievement(title: "Warrior", caption: "Complete 50 workouts", icon: "shield.fill", iconColor: .yellow, achieved: false),
        Achievement(title: "Champion", caption: "Complete 100 workouts", icon: "trophy.fill", iconColor: .orange, achieved: false)
    ]

    static let durationAchievements = [
        Achievement(title: "Tester", caption: "1 hour total workout time", icon: "clock.fill", iconColor: .blue, achieved: false),
        Achievement(title: "Beginner", caption: "5 hours total workout time", icon: "hourglass", iconColor: .cyan, achieved: false),
        Achievement(title: "Regular", caption: "10 hours total workout time", icon: "hourglass.bottomhalf.filled", iconColor: .teal, achieved: false),
        Achievement(title: "Committed", caption: "24 hours total workout time", icon: "figure.walk", iconColor: .green, achieved: false),
        Achievement(title: "Devoted", caption: "48 hours total workout time", icon: "figure.run", iconColor: .yellow, achieved: false),
        Achievement(title: "Expert", caption: "100 hours total workout time", icon: "flame.fill", iconColor: .orange, achieved: false)
    ]

    static let miscAchievements = [
        Achievement(title: "Curious", caption: "Try 3 different workouts", icon: "eye.fill", iconColor: .blue, achieved: false),
        Achievement(title: "Explorer", caption: "Try 5 different workouts", icon: "map.fill", iconColor: .cyan, achieved: false),
        Achievement(title: "Adventurer", caption: "Try 10 different workouts", icon: "globe", iconColor: .teal, achieved: false),
        Achievement(title: "Creator", caption: "Created first custom workout", icon: "pencil", iconColor: .green, achieved: false),
        Achievement(title: "Scheduler", caption: "Saved a template workout", icon: "calendar", iconColor: .yellow, achieved: false),
        Achievement(title: "Early Bird", caption: "Completed a workout before 6 AM", icon: "sunrise.fill", iconColor: .orange, achieved: false)
    ]
}
