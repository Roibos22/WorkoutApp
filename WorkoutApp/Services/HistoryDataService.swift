//
//  HistoryDataService.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import Foundation

class HistoryDataService {
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchWorkoutHistory() -> [CompletedWorkout] {
        return dataManager.loadCompletedWorkouts()
    }
    
    func saveWorkoutHistory(workouts: [CompletedWorkout]) {
        return dataManager.saveCompletedWorkouts(workouts)
    }
    
    func saveCompletedWorkoutSession(_ session: CompletedWorkout) {
        var history = dataManager.loadCompletedWorkouts()
        history.append(session)
        dataManager.saveCompletedWorkouts(history)
    }
}
