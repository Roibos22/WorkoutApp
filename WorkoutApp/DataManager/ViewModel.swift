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
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            workouts = try JSONDecoder().decode([Workout].self, from: data)
        } catch {
            workouts = []
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
    
    func addWorkout(workout: Workout) {
        workouts.append(workout)
        save()
    }
    
    func updateData(workout: Workout) {
        if let index = workouts.firstIndex(where: {$0.id == workout.id}) {
            workouts[index] = workout.updateCompletion()
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
