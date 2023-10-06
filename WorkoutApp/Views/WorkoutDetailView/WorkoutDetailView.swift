//
//  WorkoutDetailView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 06.10.23.
//

import SwiftUI



struct WorkoutDetailView: View {
    
    let workout: Workout
    
    var body: some View {
        NavigationView {
            VStack {
                // Button Section
                HStack {
                }
                // Workout Settings
                WorkoutSettingsSection()
                // Exercises
                VStack {
                    HStack() {
                        Image(systemName: "dumbbell.fill")
                        Text(" Exercises")
                        Spacer()
                    }
                    .font(.title2)
                    .bold()
                }
                Spacer()
            }
            .padding()
            .navigationTitle(workout.title)
        }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: Workout.sampleWorkouts[0])
    }
}
