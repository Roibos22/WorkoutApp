//
//  WorkoutDetailView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 06.10.23.
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
                // Workout
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
                ExerciseCardView(exercise: exercise)
            }
        }
    }
}

struct WorkoutDetailView: View {
    
    let workout: Workout
    
    var body: some View {
        NavigationView {
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
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailView(workout: Workout.sampleWorkouts[0])
    }
}
