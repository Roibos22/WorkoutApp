//
//  WorkoutDetailViewButtonSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutDetailViewButtonSection: View {
    
    let workout: Workout
    @State var completions: Int = 0
    @EnvironmentObject var vm: ViewModel
    
    var activitiesTimeline: [Activity] {
        vm.getWorkoutTimeline(workout: workout)
    }
    
    var body: some View {
        HStack {
            // Preview
            NavigationLink {
                // open Preview
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(Color.blue)
                    HStack {
                        Image(systemName: "clock.fill")
                        Text(workout.duration.asDigitalMinutes())
                    }
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                }
            }
            // Completions and History
            NavigationLink {
                WorkoutHistoryView(titleForFilter: workout.title)
                    .environmentObject(vm)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(Color.blue)
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("\(completions)x")
                    }
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                }
            }
            // Start Workout
            NavigationLink {
                WorkoutActiveView(workout: workout, workoutTimeline: activitiesTimeline, workoutTimeLeft: workout.duration, currentActivityTimeLeft: activitiesTimeline[0].duration)
                    .environmentObject(vm)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(Color.blue)
                    Text("GO!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            getWorkoutCompletions(workoutTitle: workout.title)
        }
    }
    
    func getWorkoutCompletions(workoutTitle: String?) {
        guard let workoutTitle = workoutTitle else {
            completions = vm.completedWorkouts.count
            return
        }
        completions = vm.completedWorkouts.filter { $0.workout.title == workoutTitle }.count
    }
}

struct WorkoutDetailViewButtonSection_Previews: PreviewProvider {
    static let myEnvObject = ViewModel()
    static var previews: some View {
        WorkoutDetailViewButtonSection(workout: Workout.sampleWorkouts[0])
            .environmentObject(myEnvObject)
    }
}
