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
                VStack {
                    ZStack {
                        NavigationLink(destination: WorkoutDetailView(
                            viewModel: WorkoutDetailViewModel(workout: nil, appState: appState)
                        )) {
                            Text("Hi")
                        }
                        
                    }
                    
                    ForEach(viewModel.workouts) { workout in
                        ZStack {
                            NavigationLink(destination: WorkoutDetailView(
                                viewModel: WorkoutDetailViewModel(workout: workout, appState: appState)
                            )) {
                                WorkoutCardView(workout: workout)
                                    .foregroundColor(.black)
                                    .contentShape(Rectangle())
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    .onMove(perform: viewModel.moveWorkout)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .navigationTitle("Your Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    settingsButton
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    historyButton
                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    streaksButton
//                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    addWorkoutButton
                }
            }
        }
    }
    
    private var settingsButton: some View {
        NavigationLink(destination: SettingsView()) {
            Image(systemName: "gearshape.fill")
                .foregroundColor(.primary)
                .font(.title2)
                .bold()
        }
    }
    
    private var historyButton: some View {
        NavigationLink(destination: WorkoutHistoryView(appState: appState)) {
            Image(systemName: "clock.arrow.circlepath")
                .foregroundColor(.primary)
                .font(.title2)
                .bold()
        }
    }
    
    private var streaksButton: some View {
        NavigationLink(destination: StreaksView(appState: viewModel.getAppState())) {
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.red)
                Text("\(viewModel.getCurrentStreak())")
            }
            .foregroundColor(.primary)
            .font(.title2)
            .bold()
        }
    }
    
    private var addWorkoutButton: some View {
        NavigationLink(destination: WorkoutDetailView(
            viewModel: WorkoutDetailViewModel(workout: nil, appState: appState)
        )) {
            Image(systemName: "plus.circle.fill")
                .foregroundColor(.primary)
                .font(.title2)
                .bold()
        }
    }
}

#Preview {
    let appState = AppState()
    return WorkoutListView(viewModel: WorkoutListViewModel(appState: appState))
        .environmentObject(appState)
}
