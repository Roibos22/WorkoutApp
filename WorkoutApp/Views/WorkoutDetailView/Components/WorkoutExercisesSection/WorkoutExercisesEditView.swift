//
//  WorkoutExercisesEditView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 07.08.24.
//

import SwiftUI

struct WorkoutExercisesEditView: View {
    @Binding var workout: Workout
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workout.exercises) { exercise in
                    HStack {
                        Text(exercise.title)
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .onMove(perform: viewModel.moveExercise)
                .onDelete(perform: viewModel.deleteExerciseIndexSet)
            }
            .listStyle(.plain)
            .environment(\.editMode, .constant(.active))
            .padding(.top, 30)
        }
        .navigationTitle("Edit Exercises")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    //viewModel.saveWorkout(notifyObservers: true)
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .bold()
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Edit Exercises")
                        .font(.title)
                        .bold()
                    Spacer()
                }

            }
        }
    }
}

struct WorkoutExercisesEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutExercisesEditView(workout: .constant(Workout.sampleWorkouts[0]), viewModel: WorkoutDetailViewModel(appState: AppState()))
                .padding()
        }
    }
}
