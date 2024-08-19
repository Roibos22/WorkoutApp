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
    
    func saveWorkout(_ workout: Workout, notifyObservers: Bool = false, type: WorkoutType) {
        var workouts = dataManager.loadWorkouts()
        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
            workouts[index] = workout
            //print("WDS: workout updated")
        } else {
            workouts.append(workout)
            if type == .custom {
                UserDefaults.standard.hasCreatedCustomWorkout = true
            } else if type == .preset {
                UserDefaults.standard.hasSavedTemplateWorkout = true
            }
            //print("WDS: workout added")
        }
        dataManager.saveWorkouts(workouts)
        if notifyObservers {
            print("notified observers")
            workoutsSubject.send(workouts)
        }
    }
    
    func deleteWorkout(_ workout: Workout) {
        var workouts = workoutsSubject.value
        workouts.removeAll { $0.id == workout.id }
        dataManager.saveWorkouts(workouts)
        workoutsSubject.send(workouts)
    }
    
    
    func moveWorkout(at offsets: IndexSet, to destination: Int) {
        var workouts: [Workout] = dataManager.loadWorkouts()
        workouts.move(fromOffsets: offsets, toOffset: destination)
        dataManager.saveWorkouts(workouts)
        workoutsSubject.send(workouts)
    }
    
    func moveExercise(workout: Workout, at offsets: IndexSet, to destination: Int) {
        var workouts: [Workout] = dataManager.loadWorkouts()
        
        if let workoutIndex = workouts.firstIndex(where: { $0.id == workout.id }) {
            var updatedWorkout = workouts[workoutIndex]
            updatedWorkout.exercises.move(fromOffsets: offsets, toOffset: destination)
            workouts[workoutIndex] = updatedWorkout
            
            dataManager.saveWorkouts(workouts)
            //workoutsSubject.send(workouts)
        }
    }
    
    func generateNewWorkout() -> Workout {
        var title: String = "Workout"
        var tmp: String = title
        var counter: Int = 1
        
        while dataManager.loadWorkouts().contains(where: { $0.title == tmp }) {
            counter += 1
            tmp = "\(title) \(counter)"
        }
        title = tmp
        
        return Workout(id: UUID(), title: title, cycles: 3, cycleRestTime: 60,
            exercises: [
                Exercise(title: "Exercise 1", duration: 20, rest: 10),
                Exercise(title: "Exercise 2", duration: 20, rest: 10),
                Exercise(title: "Exercise 3", duration: 20, rest: 10)
            ])
    }

}
