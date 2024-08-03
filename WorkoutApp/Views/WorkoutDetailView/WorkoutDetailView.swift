//
//  WorkoutDetailView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import SwiftUI

struct WorkoutDetailView: View {
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var showDeleteWorkoutAlert: Bool = false

    var body: some View {
        ScrollView {
            VStack {
                // Button Section
                WorkoutDetailViewButtonSection(viewModel: viewModel)
               // WorkoutDetailViewButtonSection(workout: viewModel.workout)
                
                // Workout Settings
                WorkoutSettingsSection(workout: $viewModel.workout)
                
                // Exercises
                WorkoutDetailViewExercisesSection(workout: $viewModel.workout)
                
                if !viewModel.isNewWorkout {
                   deleteWorkoutButton
                }
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle(viewModel.workout.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TextField("Workout Title", text: $viewModel.workout.title)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.title)
                    .bold()
                    .onSubmit {
                        viewModel.updateTitle(viewModel.workout.title)
                    }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    print("call saveWorkout VM from Save Button in View")
                    viewModel.saveWorkout()
                    presentationMode.wrappedValue.dismiss()
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
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
//        .onDisappear {
//            viewModel.saveWorkout()
//        }
    }
    
    private var deleteWorkoutButton: some View {
        Button(action: {
            showDeleteWorkoutAlert.toggle()
        }) {
            Text("Delete Workout")
                .foregroundColor(.white)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
        }
        .padding(.top)
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutDetailView(viewModel: WorkoutDetailViewModel(workout: Workout.sampleWorkouts[0], appState: AppState()))
        }
    }
}

//#Preview {
//    WorkoutDetailView()
//}
