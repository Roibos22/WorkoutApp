//
//  WorkoutListViewModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 02.08.24.
//

import Foundation
import Combine

class WorkoutListViewModel: ObservableObject {
    @Published var workouts: [Workout] = []
    private var cancellables = Set<AnyCancellable>()
    private let appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
            
        appState.$workouts
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] workouts in
                //print("WorkoutListViewModel received update: \(workouts.count) workouts")
                self?.workouts = workouts
                //print("WorkoutListViewModel updated: \(self?.workouts.count ?? 0) workouts")
            }
            .store(in: &cancellables)
    }
    
    func deleteWorkout(_ workout: Workout) {
        appState.deleteWorkout(workout)
    }
    
    func moveWorkout(at offsets: IndexSet, to destination: Int) {
        appState.moveWorkout(at: offsets, to: destination)
    }
    
    func deleteWorkoutIndexSet(at offsets: IndexSet) {
        let workoutsToDelete = offsets.map { workouts[$0] }
        if let workout = workoutsToDelete.first {
            appState.deleteWorkout(workout)
        }
    }
    
    func getCurrentStreak() -> Int {
        return appState.getCurrentStreak().length
    }
    
    func getAppState() -> AppState {
        return appState
    }
    
    func getLocale() -> Locale {
        return appState.getLocale()
    }
    
    func saveLocale(locale: Locale) {
        appState.saveLocale(locale: locale)
    }
    
}
