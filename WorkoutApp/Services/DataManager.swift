//
//  DataManager.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 02.08.24.
//

import Foundation

class DataManager {
    let savePathWorkouts = FileManager.documentsDirectory.appendingPathComponent("Workouts")
    let savePathCompletedWorkouts = FileManager.documentsDirectory.appendingPathComponent("CompletedWorkouts")
    
    func saveWorkouts(_ workouts: [Workout]) {
        do {
            let data = try JSONEncoder().encode(workouts)
            try data.write(to: savePathWorkouts, options: [.atomicWrite, .completeFileProtection])

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
            workouts = [
                Workout(title: "Workout", cycles: 2, cycleRestTime: 60, exercises: [
                    Exercise(title: "Push ups", duration: 20, rest: 10),
                    Exercise(title: "Crunches", duration: 20, rest: 10),
                    Exercise(title: "Exercise", duration: 20, rest: 10)
                ], completions: 0)
            ]
        }
        return workouts
    }
    
    func loadCompletedWorkouts() -> [CompletedWorkout] {
        var completedWorkouts: [CompletedWorkout]
        
        do {
            let data = try Data(contentsOf: savePathWorkouts)
            completedWorkouts  = try JSONDecoder().decode([CompletedWorkout].self, from: data)
        } catch {
            completedWorkouts = [
                CompletedWorkout(workout: Workout.sampleWorkouts[0], timestamp: Date.now),
                CompletedWorkout(workout: Workout.sampleWorkouts[1], timestamp: Date().addingTimeInterval(-86400))
            ]
        }
        return completedWorkouts
    }

}
