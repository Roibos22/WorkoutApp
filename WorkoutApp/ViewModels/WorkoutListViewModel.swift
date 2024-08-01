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
            .assign(to: \.workouts, on: self)
            .store(in: &cancellables)
    }
    
    func addWorkout(_ workout: Workout) {
        appState.workouts.append(workout)
        appState.saveData()
    }
    
    func updateWorkout(_ workout: Workout) {
        if let index = appState.workouts.firstIndex(where: { $0.id == workout.id }) {
            // possible need to remove updateCompletion
            appState.workouts[index] = workout.updateCompletion()
            appState.saveData()
        }
    }
    
    func deleteWorkout(_ workout: Workout) {
        appState.workouts.removeAll { $0.id == workout.id }
        appState.saveData()
    }
    
    func moveWorkout(at offsets: IndexSet, to int: Int) -> Void {
        appState.workouts.move(fromOffsets: offsets, toOffset: int)
        appState.saveData()
    }
}
