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
    private let workoutService: WorkoutDataService
    private let historyService: HistoryDataService
    private let timelineService: WorkoutTimelineService

    init() {
        workoutService = WorkoutDataService(dataManager: dataManager)
        historyService = HistoryDataService(dataManager: dataManager)
        timelineService = WorkoutTimelineService(dataManager: dataManager)
        loadData()
    }
    
    func loadData() {
        workouts = workoutService.fetchWorkouts()
        completedWorkouts = historyService.fetchWorkoutHistory()
    }
    
//    func saveData() {
//        dataManager.saveWorkouts(workouts)
//        dataManager.saveCompletedWorkouts(completedWorkouts)
//    }
    
    func saveWorkout(_ workout: Workout) {
        print("call saveWorkout WDS from saveWorkout AS")
        workoutService.saveWorkout(workout)
        loadData()  // Reload data to reflect changes
    }
    
    func deleteWorkout(_ workout: Workout) {
        print("AppState: Before deletion:")
        printWorkouts()
        
        workoutService.deleteWorkout(workout)
        
        print("AppState: After deletion, before loadData:")
        printWorkouts()
        
        loadData()  // Reload data to reflect changes
        
        print("AppState: After loadData:")
        printWorkouts()
    }
    
    func moveWorkout(at offsets: IndexSet, to destination: Int) {
        workoutService.moveWorkout(at: offsets, to: destination)
        loadData()  // Reload data to reflect changes
    }
    
    private func printWorkouts() {
        for (index, workout) in workouts.enumerated() {
            print("Workout \(index): ID = \(workout.id), Title = \(workout.title)")
        }
        print("Total workouts: \(workouts.count)")
        print("-------------------")
    }

}
