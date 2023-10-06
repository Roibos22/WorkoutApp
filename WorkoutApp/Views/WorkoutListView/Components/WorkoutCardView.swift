//
//  WorkoutCardView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.10.23.
//

import SwiftUI

// TODOs:
// dynamically fit the contents of the rectangle

struct WorkoutCardView: View {
    
    var workout: Workout
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // Frame of Rectangle
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 4)
                .frame(height: 190)
                .foregroundColor(.white)

            // Content of Rectangle
            VStack(alignment: .leading) {
                
                // Rectangle Title
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 50)
                        .foregroundColor(Color.blue)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 4))
                    Text(workout.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                
                // Workout Information
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "dumbbell.fill")
                            .frame(width: 50)
                        Text("Exercises: \(workout.exercises.count)")
                    }
                    .padding(1)
                    HStack {
                        Image(systemName: "repeat.circle.fill")
                            .frame(width: 50)
                        Text("Cycles: \(workout.cycles)")
                    }
                    .padding(1)
                    HStack {
                        Image(systemName: "clock.fill")
                            .frame(width: 50)
                        Text("Duration: \(workout.duration.asDigitalMinutes())")
                    }
                }
                .padding(.horizontal)
                .font(.title2)
                .bold()
            }
            
        }
    }
}

struct WorkoutCardView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCardView(workout: Workout.sampleWorkouts[0])
    }
}
