//
//  WorkoutListView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import SwiftUI

struct WorkoutListView: View {
    @ObservedObject var viewModel: WorkoutListViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(
                            viewModel: WorkoutDetailViewModel(workout: workout, appState: appState)
                        )) {
                            WorkoutCardView(workout: workout)
                                .contentShape(Rectangle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 10)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Your Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    settingsButton
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    historyButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    addWorkoutButton
                }
            }
        }
    }
    
    private var settingsButton: some View {
        Button(action: {
            // Open settings view
        }) {
            Image(systemName: "gearshape.fill")
                .foregroundColor(.primary)
                .font(.title2)
        }
    }
    
    private var historyButton: some View {
        //NavigationLink(destination: WorkoutHistoryView()) {
            Image(systemName: "clock.arrow.circlepath")
                .foregroundColor(.primary)
                .font(.title2)
       // }
    }
    
    private var addWorkoutButton: some View {
        NavigationLink(destination: WorkoutDetailView(
            viewModel: WorkoutDetailViewModel(workout: nil, appState: appState)
        )) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.primary)
                .font(.title2)
        }
    }
}

#Preview {
    let appState = AppState()
    return WorkoutListView(viewModel: WorkoutListViewModel(appState: appState))
        .environmentObject(appState)
}
