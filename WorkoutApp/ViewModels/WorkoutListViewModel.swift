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
                for workout in workouts {
                    //print("loaded 2: \(workout.title)")
                }
            }
            .store(in: &cancellables)
    }
    
    func addWorkout(_ workout: Workout) {
        appState.saveWorkout(workout)
    }
    
    func updateWorkout(_ workout: Workout) {
        appState.saveWorkout(workout)
    }
    
    func deleteWorkout(_ workout: Workout) {
        appState.deleteWorkout(workout)
    }
    
    func moveWorkout(at offsets: IndexSet, to destination: Int) {
        appState.moveWorkout(at: offsets, to: destination)
    }
    
}
