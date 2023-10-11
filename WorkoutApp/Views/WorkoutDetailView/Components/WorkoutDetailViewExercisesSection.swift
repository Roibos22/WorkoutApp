//
//  WorkoutDetailViewExercisesSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutDetailViewExercisesSection: View {
    
    let workout: Workout
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "dumbbell.fill")
                Text("Exercises")
                Spacer()
            }
            .font(.title2)
            .bold()
            ForEach(workout.exercises) { exercise in
                NavigationLink {
                    ExerciseDetailView(exercise: exercise)
                } label: {
                    ExerciseCardView(exercise: exercise)
                }
            }
        }
        //.padding(.vertical, 10)
        //.padding(.horizontal)
        .foregroundColor(.black)
    }
}

struct ExerciseCardView: View {
    
    var exercise: Exercise
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // Frame of Rectangle
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
                .frame(height: 100)
                .foregroundColor(.white)

            // Content of Rectangle
            VStack(alignment: .leading) {
                
                // Rectangle Title
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 50)
                        .foregroundColor(Color.blue)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
                    Text(exercise.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                }
                
                // Exercise Information
                HStack(alignment: .center) {
                    Spacer()
                    HStack(alignment: .center) {
                        Image(systemName: "stopwatch")
                        Text(exercise.rest.asDigitalMinutes())
                    }
                    Spacer()
                    HStack(alignment: .center) {
                        Image(systemName: "hourglass")
                        Text(exercise.duration.asDigitalMinutes())
                    }
                    Spacer()
                }
                .font(.title2)
                .bold()
            }
        }
    }
}

struct WorkoutDetailViewExercisesSection_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailViewExercisesSection(workout: Workout.sampleWorkouts[0])
    }
}
