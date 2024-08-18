//
//  File.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 19.08.24.
//

import Foundation

class AchievementsService {
    private let dataManager: DataManager
    var completedWorkouts: [CompletedWorkout]
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.completedWorkouts = dataManager.loadCompletedWorkouts()
    }
    
    func fetchAchievements() -> [AchievementGroup] {
        updateAchievements()
        return dataManager.loadAchievements()
    }
    
    func saveAchievements(achievements: [AchievementGroup]) {
        return dataManager.saveAchievements(achievements)
    }
    
    func updateAchievements() {
        updateStreaksAchievements()
        updateCompletionsAchievements()
        updateDurationsAchievements()
    }
    
    func updateStreaksAchievements() {
        var achievements = dataManager.loadAchievements()
        var streakAchievements = achievements[0].achievements
        var longestStreak = 0
        var currentStreak = 0
        
        let completedWorkouts = dataManager.loadCompletedWorkouts()
        let workoutDates = Set(completedWorkouts.map { Calendar.current.startOfDay(for: $0.timestamp) })
        
        guard let earliestDate = workoutDates.min(),
              let latestDate = workoutDates.max() else { return }
        
        var currentDate = earliestDate
        while currentDate <= latestDate {
            if workoutDates.contains(currentDate) {
                currentStreak += 1
                longestStreak = max(longestStreak, currentStreak)
            } else {
                currentStreak = 0
            }
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        print("Longest streak in days: \(longestStreak)")
        for i in 0..<streakAchievements.count {
            switch i {
                case 0: streakAchievements[i].achieved = longestStreak >= 1
                case 1: streakAchievements[i].achieved = longestStreak >= 3
                case 2: streakAchievements[i].achieved = longestStreak >= 7
                case 3: streakAchievements[i].achieved = longestStreak >= 14
                case 4: streakAchievements[i].achieved = longestStreak >= 30
                case 5: streakAchievements[i].achieved = longestStreak >= 90
                default: break
            }
        }
        
        achievements[0].achievements = streakAchievements
        dataManager.saveAchievements(achievements)
    }
    
    func updateCompletionsAchievements() {
        var achievements = dataManager.loadAchievements()
        var completionAchievements = achievements[1].achievements
        
        let completedWorkouts = dataManager.loadCompletedWorkouts()
        let totalWorkouts = completedWorkouts.count
        
        for i in 0..<completionAchievements.count {
            switch i {
            case 0: completionAchievements[i].achieved = totalWorkouts >= 1
            case 1: completionAchievements[i].achieved = totalWorkouts >= 5
            case 2: completionAchievements[i].achieved = totalWorkouts >= 15
            case 3: completionAchievements[i].achieved = totalWorkouts >= 30
            case 4: completionAchievements[i].achieved = totalWorkouts >= 50
            case 5: completionAchievements[i].achieved = totalWorkouts >= 100
            default: break
            }
        }
        
        achievements[1].achievements = completionAchievements
        dataManager.saveAchievements(achievements)
    }

    func updateDurationsAchievements() {
        let completedWorkouts = dataManager.loadCompletedWorkouts()
        var achievements = dataManager.loadAchievements()
        var durationAchievements = achievements[2].achievements  // Assuming duration achievements are the third group
        
        // Calculate total workout duration in hours
        let totalDurationHours = completedWorkouts.reduce(0.0) { total, workout in
            total + (workout.workout.duration / 3600.0)  // Convert seconds to hours
        }
        
        print(totalDurationHours)
        
        // Update achievements based on total duration
        for i in 0..<durationAchievements.count {
            switch i {
            case 0: durationAchievements[i].achieved = totalDurationHours >= 1
            case 1: durationAchievements[i].achieved = totalDurationHours >= 5
            case 2: durationAchievements[i].achieved = totalDurationHours >= 10
            case 3: durationAchievements[i].achieved = totalDurationHours >= 24
            case 4: durationAchievements[i].achieved = totalDurationHours >= 48
            case 5: durationAchievements[i].achieved = totalDurationHours >= 100
            default: break
            }
        }
        
        // Update the achievements in the main array
        achievements[2].achievements = durationAchievements
        
        // Save updated achievements
        dataManager.saveAchievements(achievements)
    }
    //func updateMiscAchievements()


}

