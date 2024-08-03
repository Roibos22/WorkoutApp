//
//  WorkoutDetailViewExercisesSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutDetailViewExercisesSection: View {
    @Binding var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            sectionHeader
            
            ForEach($workout.exercises) { $exercise in
                //NavigationLink(destination: ExerciseDetailView(exercise: $exercise)) {
                    ExerciseCardView(exercise: exercise)
                //}
            }
        }
        .foregroundColor(.primary)
    }
    
    private var sectionHeader: some View {
        HStack {
            Image(systemName: "dumbbell.fill")
            Text("Exercises")
            Spacer()
        }
        .font(.title2)
        .fontWeight(.bold)
    }
}

struct ExerciseCardView: View {
    let exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            exerciseTitle
            exerciseInfo
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
        )
    }
    
    private var exerciseTitle: some View {
        Text(exercise.title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var exerciseInfo: some View {
        HStack {
            infoItem(icon: "stopwatch", value: exercise.rest.asDigitalMinutes())
            Spacer()
            infoItem(icon: "hourglass", value: exercise.duration.asDigitalMinutes())
        }
        .padding()
        .foregroundColor(.primary)
    }
    
    private func infoItem(icon: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(value)
        }
        .font(.headline)
    }
}

struct WorkoutDetailViewExercisesSection_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutDetailViewExercisesSection(workout: .constant(Workout.sampleWorkouts[0]))
    }
}
