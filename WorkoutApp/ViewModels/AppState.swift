//
//  AppState.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 02.08.24.
//

import Foundation

class AppState: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var completedWorkouts: [CompletedWorkout] = []
    @Published var soundsEnabled: Bool = true
    
    private let dataManager = DataManager()
    
    init() {
        loadData()
    }
    
    func loadData() {
        workouts = dataManager.loadWorkouts()
        completedWorkouts = dataManager.loadCompletedWorkouts()
    }
    
    func saveData() {
        dataManager.saveWorkouts(workouts)
        dataManager.saveCompletedWorkouts(completedWorkouts)
    }
}
