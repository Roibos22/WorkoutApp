//
//  ViewModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 12.10.23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private(set) var workouts: [Workout]
   // @Published var selectedDataModel: DataModel?
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("Workouts")
    
    var placeholderWorkout = Workout(title: "Workout", cycles: 1, duration: 100, exercises: [
            Exercise(title: "Push ups", duration: 20, rest: 10),
            Exercise(title: "Crunches", duration: 20, rest: 10),
            Exercise(title: "Exercise", duration: 20, rest: 10)
        ], completions: 0)
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            workouts = try JSONDecoder().decode([Workout].self, from: data)
        } catch {
            workouts = [
                Workout(title: "Workout", cycles: 2, duration: 500, exercises: [
                    Exercise(title: "Push ups", duration: 20, rest: 10),
                    Exercise(title: "Crunches", duration: 20, rest: 10),
                    Exercise(title: "Exercise", duration: 20, rest: 10)
                ], completions: 0)
            ]
        }
    }
        
    func save() {
        do {
            let data = try JSONEncoder().encode(workouts)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    // MARK: CRUD Functions
    
    func addWorkout(workout: Workout) {
        workouts.append(workout)
        save()
    }
    
    func updateData(workout: Workout, title: String) {
        if let index = workouts.firstIndex(where: {$0.id == workout.id}) {
            workouts[index] = workout.updateCompletion()
        }
        save()
    }
    
    func updateWorkoutTitle(workout: Workout, title: String) {
        if let index = workouts.firstIndex(where: {$0.id == workout.id}) {
            workouts[index].title = title
        }
        save()
    }

    func moveData(at offsets: IndexSet, to int: Int) -> Void {
        workouts.move(fromOffsets: offsets, toOffset: int)
        save()
    }
    
    func delete(workout: Workout) {
        if let index = workouts.firstIndex(where: {$0.id == workout.id}) {
            workouts.remove(at: index)
        }
        save()
    }
}
