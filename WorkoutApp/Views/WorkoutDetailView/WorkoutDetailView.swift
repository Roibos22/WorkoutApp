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
                    .padding(.vertical, 5)
                    .padding(.top, 10)
                
                // Exercises
                WorkoutDetailViewExercisesSection(workout: $viewModel.workout)
                    .padding(.vertical, 5)

                // Workout Settings
                WorkoutSettingsSection(workout: $viewModel.workout)
                    .padding(.vertical, 5)

                if !viewModel.isNewWorkout {
                   deleteWorkoutButton
                        .padding(.vertical, 15)
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

    }
    
    private var deleteWorkoutButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.red)
                .frame(height: 50)
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2)
                .frame(height: 50)
            Text("Delete Workout")
                .font(.title2)
                .fontWeight(.bold)
        }
        .onTapGesture {
            showDeleteWorkoutAlert.toggle()
        }
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
