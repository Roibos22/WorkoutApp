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
    
    var placeholderWorkout = Workout(title: "Workout", cycles: 1, cycleRestTime: 60, duration: 100, exercises: [
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
                Workout(title: "Workout", cycles: 2, cycleRestTime: 60, duration: 500, exercises: [
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
    
    func getWorkoutTimeline(workout: Workout) -> [Activity] {
        var res: [Activity] = []
        var activityStartTime: Double = 0
        
        // protection
        if !(workout.exercises.count > 0) {
            return []
        }
        
        // create and add preperation Activity
        let newActivity = Activity(title: "Preperation", type: .countdown, duration: 10.0, timeLeft: 10.0, startingTime: activityStartTime, cycleNo: 0)
        activityStartTime += newActivity.duration
        res.append(newActivity)
        
        // for every cycle
        for i in 1...workout.cycles {
            
            // for every exercise
            for j in 1...workout.exercises.count {
                
                // create and add new Exercise Activity
                let newExerciseActivity = Activity(title: "\(workout.exercises[j-1].title)", type: .exercise, duration: workout.exercises[j-1].duration, timeLeft: workout.exercises[j-1].duration, startingTime: activityStartTime, cycleNo: i)
                activityStartTime += newExerciseActivity.duration
                res.append(newExerciseActivity)
                
                // create and add new Rest Activity if not last activity in circle
                if !(j == workout.exercises.count) {
                    let newRestActivity = Activity(title: "Rest", type: .rest, duration: workout.exercises[j-1].rest, timeLeft: workout.exercises[j-1].rest, startingTime: activityStartTime, cycleNo: i)
                    activityStartTime += newRestActivity.duration
                    res.append(newRestActivity)
                }
            }
            
            // create and add new Cycle Rest Activity if not last circle
            if !(i == workout.cycles) {
                let newCycleRestActivity = Activity(title: "Rest", type: .rest, duration: workout.cycleRestTime, timeLeft: workout.cycleRestTime, startingTime: activityStartTime, cycleNo: i)
                activityStartTime += newCycleRestActivity.duration
                res.append(newCycleRestActivity)
            }
        }
        
        // create and add Done Activity
        let doneActivity = Activity(title: "Done", type: .done, duration: 0, timeLeft: 0, startingTime: activityStartTime, cycleNo: workout.cycles)
        activityStartTime += doneActivity.duration
        res.append(doneActivity)
        
        return res
    }
}
