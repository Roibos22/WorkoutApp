//
//  ViewModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 12.10.23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private(set) var workouts: [Workout]
    
    @Published private(set) var completedWorkouts: [CompletedWorkout]
    @Published var completedWorkoutsFiltered: [CompletedWorkout]

   // @Published var selectedDataModel: DataModel?
    @Published var soundsEnabled: Bool = true
    
//    let savePathWorkouts = FileManager.documentsDirectory.appendingPathComponent("Workouts")
//    let savePathCompletedWorkouts = FileManager.documentsDirectory.appendingPathComponent("CompletedWorkouts")
//
//    var placeholderWorkout = Workout(title: "Workout", cycles: 1, cycleRestTime: 60, exercises: [
//            Exercise(title: "Push ups", duration: 20, rest: 10),
//            Exercise(title: "Crunches", duration: 20, rest: 10),
//            Exercise(title: "Exercise", duration: 20, rest: 10)
//        ], completions: 0)
    
    init() {
//        do {
//            let workoutsData = try Data(contentsOf: savePathWorkouts)
//            workouts = try JSONDecoder().decode([Workout].self, from: workoutsData)
//            let completedWorkoutsData = try Data(contentsOf: savePathCompletedWorkouts)
//            completedWorkouts = try JSONDecoder().decode([CompletedWorkout].self, from: completedWorkoutsData)
//            completedWorkoutsFiltered = try JSONDecoder().decode([CompletedWorkout].self, from: completedWorkoutsData)
//        } catch {
//            workouts = [
//                Workout(title: "Workout", cycles: 2, cycleRestTime: 60, exercises: [
//                    Exercise(title: "Push ups", duration: 20, rest: 10),
//                    Exercise(title: "Crunches", duration: 20, rest: 10),
//                    Exercise(title: "Exercise", duration: 20, rest: 10)
//                ], completions: 0)
//            ]
//            completedWorkouts = [
//                CompletedWorkout(workout: Workout.sampleWorkouts[0], timestamp: Date.now),
//                CompletedWorkout(workout: Workout.sampleWorkouts[1], timestamp: Date().addingTimeInterval(-86400))
//            ]
//            completedWorkoutsFiltered = [
//                CompletedWorkout(workout: Workout.sampleWorkouts[0], timestamp: Date.now),
//                CompletedWorkout(workout: Workout.sampleWorkouts[1], timestamp: Date().addingTimeInterval(-86400))
//            ]
//        }
    }
    
    func filterWorkoutsForHistory(workoutTitle: String?) {
        guard let workoutTitle = workoutTitle else {
            completedWorkoutsFiltered = completedWorkouts
            return
        }
        completedWorkoutsFiltered = completedWorkouts.filter { $0.workout.title == workoutTitle }
    }

        
//    func save() {
//        do {
//            let workoutsData = try JSONEncoder().encode(workouts)
//            let completedWorkoutsData = try JSONEncoder().encode(completedWorkouts)
//            try workoutsData.write(to: savePathWorkouts, options: [.atomicWrite, .completeFileProtection])
//            try completedWorkoutsData.write(to: savePathCompletedWorkouts, options: [.atomicWrite, .completeFileProtection])
//        } catch {
//            print("Unable to save data.")
//        }
//    }
    
    // MARK: CRUD FUNCTIONS COMPLETED WORKOUTS

    func addCompletedWorkout(workout: Workout) {
        let newCompletedWorkout = CompletedWorkout(workout: workout, timestamp: Date.now)
        completedWorkouts.append(newCompletedWorkout)
        save()
    }
    
    // MARK: CRUD FUNCTIONS WORKOUTS
    
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
        for index in completedWorkouts.indices where completedWorkouts[index].workout.title == workout.title {
            completedWorkouts[index].workout.title = title
        }
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
        let newActivity = Activity(title: "Preperation", type: .countdown, duration: 10.0, timeLeft: 10.0, startingTime: activityStartTime, cycleNo: 0, activityNo: 0)
        activityStartTime += newActivity.duration
        res.append(newActivity)
        
        // for every cycle
        for i in 1...workout.cycles {
            
            // for every exercise
            for j in 1...workout.exercises.count {
                
                // create and add new Exercise Activity
                let newExerciseActivity = Activity(title: "\(workout.exercises[j-1].title)", type: .exercise, duration: workout.exercises[j-1].duration, timeLeft: workout.exercises[j-1].duration, startingTime: activityStartTime, cycleNo: i, activityNo: j)
                activityStartTime += newExerciseActivity.duration
                res.append(newExerciseActivity)
                
                // create and add new Rest Activity if not last activity in circle
                if !(j == workout.exercises.count) {
                    let newRestActivity = Activity(title: "Rest", type: .rest, duration: workout.exercises[j-1].rest, timeLeft: workout.exercises[j-1].rest, startingTime: activityStartTime, cycleNo: i, activityNo: j)
                    activityStartTime += newRestActivity.duration
                    res.append(newRestActivity)
                }
            }
            
            // create and add new Cycle Rest Activity if not last circle
            if !(i == workout.cycles) {
                let newCycleRestActivity = Activity(title: "Rest", type: .rest, duration: workout.cycleRestTime, timeLeft: workout.cycleRestTime, startingTime: activityStartTime, cycleNo: i, activityNo: 0)
                activityStartTime += newCycleRestActivity.duration
                res.append(newCycleRestActivity)
            }
        }
        
        // create and add Done Activity
        let doneActivity = Activity(title: "Done", type: .done, duration: 0, timeLeft: 0, startingTime: activityStartTime, cycleNo: workout.cycles, activityNo: workout.exercises.count)
        activityStartTime += doneActivity.duration
        res.append(doneActivity)
        
        return res
    }
    
    func getCycleTimeline(workout: Workout) -> [Cycle] {
        
        var finalCylesArray = [Cycle]()
        var startingTime: Double = 0
        
        //append preperation cycle
        var newCycle = Cycle(title: "Preparation cycle", duration: 0.0, startingTime: 0.0, activities: [Activity](), cycleNumber: 0)
        let newActivity = Activity(title: "Preparation", type: .countdown, duration: 10.0, timeLeft: 10.0, startingTime: startingTime, cycleNo: 0, activityNo: 0)
        startingTime += newActivity.duration
        newCycle.activities.append(newActivity)
        finalCylesArray.append(newCycle)
        
        if workout.exercises.count > 0 {
            for i in 1...workout.cycles {
                var newCycle = Cycle(title: "Cycle \(workout.cycles)", duration: 0.0, startingTime: 0.0, activities: [Activity](), cycleNumber: i)
                
                for j in 1...workout.exercises.count {
                    let newActivity = Activity(title: "\(workout.exercises[j-1].title)", type: .exercise, duration: workout.exercises[j-1].duration, timeLeft: workout.exercises[j-1].duration, startingTime: startingTime, cycleNo: i, activityNo: j)
                    startingTime += newActivity.duration
                    newCycle.activities.append(newActivity)
                    
                    // append rest activity after workout activity
                    // only if not last workout activity of cycle
                    // if k != tabata.exercises.count && j != tabata.setsAmount
                    if j == workout.exercises.count {
                        // do nothing
                    } else {
                        let restActivity = Activity(title: "Rest", type: .rest, duration: workout.exercises[j-1].rest, timeLeft: workout.exercises[j-1].rest, startingTime: startingTime, cycleNo: i, activityNo: j)
                        startingTime += restActivity.duration
                        newCycle.activities.append(restActivity)
                    }
                    finalCylesArray.append(newCycle)
                    
                    // only append cycle rest time if not last cycle
                    
                    if i != workout.cycles {
                        var restCycle = Cycle(title: "", duration: 0.0, startingTime: 0.0, activities: [Activity](), cycleNumber: 0)
                        let cycleRestTime = Activity(title: "Recovery cycle", type: .rest, duration: workout.cycleRestTime, timeLeft: 0.0, startingTime: startingTime, cycleNo: i, activityNo: j)
                        startingTime += cycleRestTime.duration
                        restCycle.activities.append(cycleRestTime)
                        finalCylesArray.append(restCycle)
                    }
                }
            }
        }
        return finalCylesArray
    }
}
