//
//  WorkoutDataService.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import Foundation
import Combine

class WorkoutDataService {
    private let dataManager: DataManager
    private var workoutsSubject = CurrentValueSubject<[Workout], Never>([])
    
    var workoutsPublisher: AnyPublisher<[Workout], Never> {
        workoutsSubject.eraseToAnyPublisher()
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        loadWorkouts()
    }
    
    func fetchWorkouts() -> [Workout] {
        return workoutsSubject.value
    }
    
    private func loadWorkouts() {
        let workouts = dataManager.loadWorkouts()
        workoutsSubject.send(workouts)
    }
    
    func saveWorkout(_ workout: Workout) {
        print("saveWorkout in WDS")
        var workouts = dataManager.loadWorkouts()
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[index] = workout
        } else {
            workouts.append(workout)
        }
        dataManager.saveWorkouts(workouts)
        workoutsSubject.send(workouts)
    }
    
    func deleteWorkout(_ workout: Workout) {
        var workouts = workoutsSubject.value
        workouts.removeAll { $0.id == workout.id }
        dataManager.saveWorkouts(workouts)
        workoutsSubject.send(workouts)
    }
    
    
    func moveWorkout(at offsets: IndexSet, to destination: Int) {
        var workouts = dataManager.loadWorkouts()
        workouts.move(fromOffsets: offsets, toOffset: destination)
        dataManager.saveWorkouts(workouts)
    }
}
