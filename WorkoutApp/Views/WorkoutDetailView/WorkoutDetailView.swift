//
//  WorkoutDetailView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import SwiftUI

struct WorkoutDetailView: View {
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @Environment(\.dismiss) var dismiss

    @State private var showDeleteWorkoutAlert: Bool = false
    
    let workoutType: WorkoutType

    var body: some View {
        ScrollView {
            VStack {
                WorkoutDetailViewButtonSection(viewModel: viewModel, workoutType: workoutType)
                    .padding(.vertical, 10)
                
                WorkoutDetailViewExercisesSection(workout: $viewModel.workout, viewModel: viewModel, workoutType: workoutType)
                    .padding(.vertical, 10)
                
                WorkoutSettingsSection(workout: $viewModel.workout, workoutType: workoutType)
                    .padding(.vertical, 10)
                
                if workoutType == .custom {
                    deleteWorkoutButton
                        .padding(.vertical, 10)
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle(viewModel.workout.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    if workoutType == .custom {
                        viewModel.saveWorkout(notifyObservers: true)
                    }
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .bold()
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                if workoutType == .custom {
                    TextField("Workout Title", text: $viewModel.workout.title)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.title)
                        .bold()
                        .onSubmit {
                            viewModel.updateTitle(viewModel.workout.title)
                        }
                } else if workoutType == .preset {
                    HStack {
                        Text(viewModel.workout.title)
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    
                }
                
            }
        }
        .confirmationDialog(
            Text("Delete Workout?"),
            isPresented: $showDeleteWorkoutAlert,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                viewModel.deleteWorkout()
                DispatchQueue.main.async {
                    dismiss()
                }
            }
        }

    }
    
    private var deleteWorkoutButton: some View {
        Image(systemName: "trash")
            .foregroundColor(Color.red)
            .font(.title)
            .onTapGesture {
                showDeleteWorkoutAlert.toggle()
            }
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutDetailView(viewModel: WorkoutDetailViewModel(workout: Workout.defaultWorkouts[0], appState: AppState()), workoutType: .custom)
                .environmentObject(AppState())
        }
    }
}
