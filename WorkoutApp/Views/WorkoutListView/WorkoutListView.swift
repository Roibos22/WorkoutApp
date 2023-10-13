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
                            WorkoutDetailView(workout: workout)
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
                    Button {
                        // open history view
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .foregroundColor(.black)
                            .bold()
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button {
                        // create and add new workout
                        let workout = Workout(title: "New", cycles: 1, duration: 100, exercises: [
                            Exercise(title: "Exercise", duration: 20, rest: 10)
                        ], completions: 0)
                        vm.addWorkout(workout: workout)
                        // open add workout view

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
    static var previews: some View {
        WorkoutListView()
    }
}

/*
struct TabataDetailView3_Previews: PreviewProvider {
    static let myEnvObject = ViewModel()
    static var previews: some View {
        NavigationView {
            TabataDetailView(tabata: dev.tabataOne)
                .environmentObject(myEnvObject)
                .environment(\.locale, .init(identifier: "de"))
        }
    }
}
*/
