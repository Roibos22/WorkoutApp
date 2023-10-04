//
//  ContentView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.10.23.
//

import SwiftUI

struct ContentView: View {
    
    let workouts: [Workout] = Workout.sampleWorkouts
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(workouts) { workout in
                        WorkoutCardView(workout: workout)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
