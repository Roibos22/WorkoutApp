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
        timelineService = WorkoutTimelineService()
        loadData()
    }
    
    func loadData() {
        workouts = workoutService.fetchWorkouts()
        completedWorkouts = historyService.fetchWorkoutHistory()
    }
    
    func loadCompletedWorkout() {
        completedWorkouts = historyService.fetchWorkoutHistory()
    }
    
    func generateNewWorkout() -> Workout {
        return workoutService.generateNewWorkout()
    }
    
    func saveWorkout(_ workout: Workout, notifyObservers: Bool = false) {
        workoutService.saveWorkout(workout, notifyObservers: notifyObservers)
        if notifyObservers {
            self.workouts = workoutService.fetchWorkouts()
            print("workouts loaded")
        }
    }
    
    func deleteWorkout(_ workout: Workout) {
        workoutService.deleteWorkout(workout)
        loadData()  // Reload data to reflect changes
    }
    
    func moveWorkout(at offsets: IndexSet, to destination: Int) {
        workoutService.moveWorkout(at: offsets, to: destination)
        loadData()  // Reload data to reflect changes
    }
    
    func moveExercise(workout: Workout, at offsets: IndexSet, to destination: Int) {
        workoutService.moveExercise(workout: workout, at: offsets, to: destination)
        //loadData()  // Reload data to reflect changes
    }
    
    func createWorkoutTimeline(workout: Workout) -> [Activity] {
        return timelineService.createWorkoutTimeline(workout: workout)
    }
    
    func createCycleimeline(workout: Workout) -> [Cycle] {
        return timelineService.createCycleTimeline(workout: workout)
    }
    
    func getWorkoutsHistory() -> [CompletedWorkout] {
        historyService.fetchWorkoutHistory()
    }
    
    func saveCompletedWorkoutSession(_ workout: Workout) {
        let session = CompletedWorkout(workout: workout, timestamp: Date())
        historyService.saveCompletedWorkoutSession(session)
    }
    
    func updateTitleCompletedWorkouts(workout: Workout, title: String) {
        let completedWorkouts = getWorkoutsHistory()
        var updatedCompletedWorkouts: [CompletedWorkout] = []
        
        for completedWorkout in completedWorkouts {
            if completedWorkout.workout.id == workout.id {
                let updatedCompletedWorkout = CompletedWorkout(
                    id: completedWorkout.id,
                    workout: Workout(id: workout.id, title: title, cycles: workout.cycles, cycleRestTime: workout.cycleRestTime, exercises: workout.exercises),
                    timestamp: completedWorkout.timestamp
                )
                updatedCompletedWorkouts.append(updatedCompletedWorkout)
            } else {
                updatedCompletedWorkouts.append(completedWorkout)
            }
        }
        
       // completedWorkouts = updatedCompletedWorkouts
        historyService.saveWorkoutHistory(workouts: updatedCompletedWorkouts)
    }
    
    func getCurrentStreak() -> Int {
        let sortedWorkouts = completedWorkouts.sorted { $0.timestamp > $1.timestamp }
        guard !sortedWorkouts.isEmpty else { return 0 }

        let calendar = Calendar.current
        var streak = 1
        var lastWorkoutDate = calendar.startOfDay(for: sortedWorkouts[0].timestamp)

        for i in 1..<sortedWorkouts.count {
            let currentWorkoutDate = calendar.startOfDay(for: sortedWorkouts[i].timestamp)
            let daysBetween = calendar.dateComponents([.day], from: currentWorkoutDate, to: lastWorkoutDate).day ?? 0

            if daysBetween == 1 {
                streak += 1
                lastWorkoutDate = currentWorkoutDate
            } else if daysBetween > 1 {
                break
            }
        }

        return streak
    }

}
