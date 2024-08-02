//
//  WorkoutDataService.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import Foundation

class WorkoutDataService {
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchWorkouts() -> [Workout] {
        return dataManager.loadWorkouts()
    }
    
    func saveWorkout(_ workout: Workout) {
        var workouts = dataManager.loadWorkouts()
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[index] = workout
        } else {
            workouts.append(workout)
        }
        dataManager.saveWorkouts(workouts)
    }
    
    func deleteWorkout(_ workout: Workout) {
        var workouts = dataManager.loadWorkouts()
        workouts.removeAll { $0.id == workout.id }
        dataManager.saveWorkouts(workouts)
    }
    
    func moveWorkout(at offsets: IndexSet, to destination: Int) {
        var workouts = dataManager.loadWorkouts()
        workouts.move(fromOffsets: offsets, toOffset: destination)
        dataManager.saveWorkouts(workouts)
    }
}
