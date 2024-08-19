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
    var iconColorHex: String
    var achieved: Bool
    var value: Int
    
    var iconColor: Color {
        Color(hex: iconColorHex)
    }
    
    init(id: UUID = UUID(), title: String, caption: String, icon: String, iconColor: Color, achieved: Bool, value: Double) {
        self.id = id
        self.title = title
        self.caption = caption
        self.icon = icon
        self.iconColorHex = iconColor.toHex() ?? "#000000"
        self.achieved = achieved
        self.value = value
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
        Achievement(title: "Newbie", caption: "Work out for 1 day", icon: "figure.walk", iconColor: .blue, achieved: false, value: 1),
        Achievement(title: "Starter", caption: "3-day workout streak", icon: "stopwatch.fill", iconColor: .cyan, achieved: false, value: 3),
        Achievement(title: "Weekly", caption: "7-day workout streak", icon: "calendar", iconColor: .teal, achieved: false, value: 7),
        Achievement(title: "Fortnight", caption: "14-day workout streak", icon: "flame.fill", iconColor: .green, achieved: false, value: 14),
        Achievement(title: "Monthly", caption: "30-day workout streak", icon: "moon.stars.fill", iconColor: .yellow, achieved: false, value: 30),
        Achievement(title: "Champion", caption: "90-day workout streak", icon: "trophy.fill", iconColor: .orange, achieved: false, value: 90)
    ]

    static let completionAchievements = [
        Achievement(title: "Newbie", caption: "Complete 1 workout", icon: "leaf.fill", iconColor: .blue, achieved: false, value: 1),
        Achievement(title: "Starter", caption: "Complete 5 workouts", icon: "checkmark.circle.fill", iconColor: .cyan, achieved: false, value: 5),
        Achievement(title: "Consistent", caption: "Complete 15 workouts", icon: "figure.walk", iconColor: .teal, achieved: false, value: 15),
        Achievement(title: "Dedicated", caption: "Complete 30 workouts", icon: "dumbbell.fill", iconColor: .green, achieved: false, value: 30),
        Achievement(title: "Warrior", caption: "Complete 50 workouts", icon: "shield.fill", iconColor: .yellow, achieved: false, value: 50),
        Achievement(title: "Champion", caption: "Complete 100 workouts", icon: "trophy.fill", iconColor: .orange, achieved: false, value: 100)
    ]

    static let durationAchievements = [
        Achievement(title: "Tester", caption: "1 hour total workout time", icon: "clock.fill", iconColor: .blue, achieved: false, value: 1),
        Achievement(title: "Beginner", caption: "5 hours total workout time", icon: "hourglass", iconColor: .cyan, achieved: false, value: 5),
        Achievement(title: "Regular", caption: "10 hours total workout time", icon: "hourglass.bottomhalf.filled", iconColor: .teal, achieved: false, value: 10),
        Achievement(title: "Committed", caption: "24 hours total workout time", icon: "figure.walk", iconColor: .green, achieved: false, value: 24),
        Achievement(title: "Devoted", caption: "48 hours total workout time", icon: "figure.run", iconColor: .yellow, achieved: false, value: 48),
        Achievement(title: "Expert", caption: "100 hours total workout time", icon: "flame.fill", iconColor: .orange, achieved: false, value: 100)
    ]

    static let miscAchievements = [
        Achievement(title: "Curious", caption: "Try 3 different workouts", icon: "eye.fill", iconColor: .blue, achieved: false, value: 3),
        Achievement(title: "Explorer", caption: "Try 5 different workouts", icon: "map.fill", iconColor: .cyan, achieved: false, value: 5),
        Achievement(title: "Adventurer", caption: "Try 10 different workouts", icon: "globe", iconColor: .teal, achieved: false, value: 10),
        Achievement(title: "Creator", caption: "Created first custom workout", icon: "pencil", iconColor: .green, achieved: false, value: 0),
        Achievement(title: "Scheduler", caption: "Saved a template workout", icon: "calendar", iconColor: .yellow, achieved: false, value: 0),
        Achievement(title: "Early Bird", caption: "Completed a workout before 6 AM", icon: "sunrise.fill", iconColor: .orange, achieved: false, value: 0)
    ]
}
