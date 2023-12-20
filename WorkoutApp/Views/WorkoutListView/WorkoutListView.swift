//
//  WorkoutListView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 06.10.23.
//

import SwiftUI

struct WorkoutListView: View {
    
    @EnvironmentObject var vm: ViewModel
    let workouts: [Workout] = Workout.sampleWorkouts
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(vm.workouts) { workout in
                        NavigationLink {
                            WorkoutDetailView(workout: workout, createNew: false, workoutTitle: workout.title)
                                .environmentObject(vm)
                        } label: {
                            WorkoutCardView(workout: workout)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button {
                        // open settings view
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.black)
                            .bold()
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    NavigationLink {
                        WorkoutHistoryView(titleForFilter: nil)
                            .environmentObject(vm)
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(.black)
                            .bold()
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink {
                        WorkoutDetailView(workout: Workout.newWorkout, createNew: true, workoutTitle: Workout.newWorkout.title)
                             .environmentObject(vm)
                        // create copy of workout and inject here
                        // in DetailView: after 1 sec, check if workout already exists and save
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
                            .bold()
                            .font(.title2)
                    }
                }
            }
            .navigationTitle("Your Workouts")
        }
    }
}

struct WorkoutListView_Previews: PreviewProvider {
    static let myEnvObject = ViewModel()
    static var previews: some View {
        WorkoutListView()
            .environmentObject(myEnvObject)
    }
}


