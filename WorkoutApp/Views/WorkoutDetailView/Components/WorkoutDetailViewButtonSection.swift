//
//  WorkoutDetailViewButtonSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutDetailViewButtonSection: View {
    
    let workout: Workout
    
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
                // open History
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 60)
                        .foregroundColor(Color.blue)
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("\(workout.completions)x")
                    }
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                }
            }
            // Start Workout
            NavigationLink {
                WorkoutActiveView(workout: workout)
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
    }
}

struct WorkoutDetailViewButtonSection_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailViewButtonSection(workout: Workout.sampleWorkouts[0])
    }
}
