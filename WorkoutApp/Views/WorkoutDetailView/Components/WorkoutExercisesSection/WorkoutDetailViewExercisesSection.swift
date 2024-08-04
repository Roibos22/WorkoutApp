//
//  WorkoutDetailViewExercisesSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutDetailViewExercisesSection: View {
    @Binding var workout: Workout
    @ObservedObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Exercises")
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach($workout.exercises) { $exercise in
                NavigationLink(destination: ExerciseDetailView(viewModel: ExerciseDetailViewModel(exercise: exercise, workoutViewModel: viewModel) {
                    // This closure will be called when the exercise is deleted
                    viewModel.objectWillChange.send()
                })) {
                    ExerciseCardView(exercise: exercise)
                }
            }
            
//            Button(action: {
//                workout.exercises.append(Exercise())
//            }) {
//                Label("Add Exercise", systemImage: "plus.circle")
//            }
//            .padding(.top, 10)
        }
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
            .frame(maxWidth: .infinity, minHeight: 40)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
    
    private var exerciseInfo: some View {
        HStack {
            HStack {
                Image(systemName: "stopwatch")
                Text(exercise.duration.asDigitalMinutes())
            }
            
            Spacer()
            HStack {
                Image(systemName: "hourglass")
                Text(exercise.rest.asDigitalMinutes())
            }

        }
        .padding(.vertical, 10)
        .padding(.horizontal, 50)
        .foregroundColor(.primary)
        .font(.title3)
        .bold()
    }
    

}

//struct WorkoutDetailViewExercisesSection_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutDetailViewExercisesSection(workout: .constant(Workout.sampleWorkouts[0]))
//            .padding()
//    }
//}
