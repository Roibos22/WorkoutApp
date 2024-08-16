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
            completedWorkouts = [ ] // Workout.sampleWorkoutHistory
        }
        return completedWorkouts
    }

}
