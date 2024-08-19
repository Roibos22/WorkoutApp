//
//  DataManager.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 02.08.24.
//

import Foundation
import SwiftUI

class DataManager {
    let savePathWorkouts = FileManager.documentsDirectory.appendingPathComponent("Workouts")
    let savePathCompletedWorkouts = FileManager.documentsDirectory.appendingPathComponent("CompletedWorkouts")
    let savePathAchievements = FileManager.documentsDirectory.appendingPathComponent("Achievements")

    func saveWorkouts(_ workouts: [Workout]) {
        do {
            let data = try JSONEncoder().encode(workouts)
            try data.write(to: savePathWorkouts, options: [.atomicWrite, .completeFileProtection])
            for workout in workouts {
                print("saved \(workout.title)")
            }
        } catch {
            print("Failed to save workouts: \(error.localizedDescription)")
        }
    }
    
    func saveCompletedWorkouts(_ completedWorkouts: [CompletedWorkout]) {
        do {
            let data = try JSONEncoder().encode(completedWorkouts)
            try data.write(to: savePathCompletedWorkouts, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to save completed workouts: \(error.localizedDescription)")
        }
    }
    
    func saveAchievements(_ achievements: [AchievementGroup]) {
        do {
            let data = try JSONEncoder().encode(achievements)
            try data.write(to: savePathAchievements, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Failed to save completed workouts: \(error.localizedDescription)")
        }
    }
    
    func loadAchievements() -> [AchievementGroup] {
        var achievements: [AchievementGroup]
        
        do {
            let data = try Data(contentsOf: savePathAchievements)
            achievements  = try JSONDecoder().decode([AchievementGroup].self, from: data)
        } catch {
            achievements = Achievement.achievements
            saveAchievements(achievements)
        }
        return achievements
    }
    
    func loadWorkouts() -> [Workout] {
        var workouts: [Workout]
        
        do {
            let data = try Data(contentsOf: savePathWorkouts)
            workouts  = try JSONDecoder().decode([Workout].self, from: data)
        } catch {
            workouts = Workout.defaultWorkouts
            saveWorkouts(workouts)
        }
        return workouts
    }
    
    func loadCompletedWorkouts() -> [CompletedWorkout] {
        var completedWorkouts: [CompletedWorkout]
        
        do {
            let data = try Data(contentsOf: savePathCompletedWorkouts)
            completedWorkouts  = try JSONDecoder().decode([CompletedWorkout].self, from: data)
        } catch {
            completedWorkouts = [ ]
        }
        return completedWorkouts
    }

}
