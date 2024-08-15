//
//  EditWorkoutsView.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 15.08.24.
//

import SwiftUI

struct EditWorkoutsView: View {
    @ObservedObject var viewModel: WorkoutListViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.workouts) { workout in
                    HStack {
                        Text(workout.title)
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .onMove(perform: viewModel.moveWorkout)
                .onDelete(perform: viewModel.deleteWorkoutIndexSet)
            }
            .listStyle(.plain)
            .environment(\.editMode, .constant(.active))
            .padding(.top, 30)
        }
        .navigationTitle("Edit Workouts")
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
                    Text("Edit Workouts")
                        .font(.title)
                        .bold()
                    Spacer()
                }

            }
        }
//        .alert(isPresented: $viewModel.showDeleteNotPossibleAlert) {
//            Alert(
//                title: Text("Deletion not possible"),
//                message: Text("You need to have at least one Exercise in your workout."),
//                dismissButton: .default(Text("OK")) { }
//            )
//        }
    }
}


#Preview {
    EditWorkoutsView(viewModel: WorkoutListViewModel(appState: AppState()))
}
