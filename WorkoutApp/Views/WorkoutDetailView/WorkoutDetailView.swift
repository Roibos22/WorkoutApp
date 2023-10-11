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

            ScrollView {
                VStack {
                    
                    // Button Section
                    WorkoutDetailViewButtonSection(workout: workout)

                    // Workout Settings
                    WorkoutSettingsSection()
                    
                    // Exercises
                    WorkoutDetailViewExercisesSection(workout: workout)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .navigationTitle(workout.title)
            }
        }

}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: Workout.sampleWorkouts[0])
    }
}
