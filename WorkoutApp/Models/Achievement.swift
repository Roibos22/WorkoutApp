//
//  Achievement.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 17.08.24.
//

import Foundation
import SwiftUI

enum AchievementGroupType: String, Codable {
    case streaks = "Streaks"
    case completions = "Completions"
    case duration = "Duration"
    case misc = "Miscellaneous"
}

struct AchievementGroup: Identifiable, Codable {
    var id = UUID()
    var title: String
    var type: AchievementGroupType
    var achievements: [Achievement]
    
    init(id: UUID = UUID(), title: String, type: AchievementGroupType, achievements: [Achievement]) {
        self.id = id
        self.title = title
        self.type = type
        self.achievements = achievements
    }
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
    
    init(id: UUID = UUID(), title: String, caption: String, icon: String, iconColor: Color, achieved: Bool, value: Int) {
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
        AchievementGroup(title: "Streaks", type: .streaks, achievements: streakAchievements),
        AchievementGroup(title: "Completions", type: .completions, achievements: completionAchievements),
        AchievementGroup(title: "Duration", type: .duration, achievements: durationAchievements),
        AchievementGroup(title: "More", type: .misc, achievements: miscAchievements)
    ]
    
    static let streakAchievements = [
        Achievement(title: "Kickoff", caption: "Work out for 1 day", icon: "figure.walk", iconColor: .blue, achieved: false, value: 1),
        Achievement(title: "Tripler", caption: "3-day workout streak", icon: "stopwatch.fill", iconColor: .cyan, achieved: false, value: 3),
        Achievement(title: "Weeklong", caption: "7-day workout streak", icon: "calendar", iconColor: .teal, achieved: false, value: 7),
        Achievement(title: "Fortnight", caption: "14-day workout streak", icon: "flame.fill", iconColor: .green, achieved: false, value: 14),
        Achievement(title: "Monthly", caption: "30-day workout streak", icon: "moon.stars.fill", iconColor: .yellow, achieved: false, value: 30),
        Achievement(title: "Eternity", caption: "90-day workout streak", icon: "medal.fill", iconColor: .orange, achieved: false, value: 90)
    ]

    static let completionAchievements = [
        Achievement(title: "Newbie", caption: "Complete 1 workout", icon: "leaf.fill", iconColor: .blue, achieved: false, value: 1),
        Achievement(title: "Starter", caption: "Complete 5 workouts", icon: "rosette", iconColor: .cyan, achieved: false, value: 5),
        Achievement(title: "Consistent", caption: "Complete 15 workouts", icon: "dumbbell.fill", iconColor: .teal, achieved: false, value: 15),
        Achievement(title: "Committed", caption: "Complete 30 workouts", icon: "shield.fill", iconColor: .green, achieved: false, value: 30),
        Achievement(title: "Unstoppable", caption: "Complete 50 workouts", icon: "bolt.fill", iconColor: .yellow, achieved: false, value: 50),
        Achievement(title: "Champion", caption: "Complete 100 workouts", icon: "trophy.fill", iconColor: .orange, achieved: false, value: 100)
    ]

    static let durationAchievements = [
        Achievement(title: "Timekeeper", caption: "1 hour total workout time", icon: "clock.fill", iconColor: .blue, achieved: false, value: 1),
        Achievement(title: "Dedicated", caption: "5 hours total workout time", icon: "hourglass.bottomhalf.filled", iconColor: .cyan, achieved: false, value: 5),
        Achievement(title: "Persistent", caption: "10 hours total workout time", icon: "hourglass", iconColor: .teal, achieved: false, value: 10),
        Achievement(title: "Enduring", caption: "24 hours total workout time", icon: "chart.line.uptrend.xyaxis.circle.fill", iconColor: .green, achieved: false, value: 24),
        Achievement(title: "Resilient", caption: "48 hours total workout time", icon: "figure.run", iconColor: .yellow, achieved: false, value: 48),
        Achievement(title: "Centurion", caption: "100 hours total workout time", icon: "flame.fill", iconColor: .orange, achieved: false, value: 100)
    ]

    static let miscAchievements = [
        Achievement(title: "Designer", caption: "Create first custom workout", icon: "paintbrush.fill", iconColor: .blue, achieved: false, value: 0),
        Achievement(title: "Organizer", caption: "Saved a template workout", icon: "calendar", iconColor: .cyan, achieved: false, value: 0),
        Achievement(title: "Curious", caption: "Try 3 different workouts", icon: "eye.fill", iconColor: .teal, achieved: false, value: 3),
        Achievement(title: "Explorer", caption: "Try 5 different workouts", icon: "map.fill", iconColor: .green, achieved: false, value: 5),
        Achievement(title: "Adventurer", caption: "Try 10 different workouts", icon: "globe", iconColor: .yellow, achieved: false, value: 10),
        Achievement(title: "Early Bird", caption: "Complete a workout before 6 AM", icon: "sunrise.fill", iconColor: .orange, achieved: false, value: 0)
    ]
}
