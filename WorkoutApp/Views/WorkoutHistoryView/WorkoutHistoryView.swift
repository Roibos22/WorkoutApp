//
//  WorkoutHistoryView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 20.12.23.
//

import SwiftUI

struct WorkoutHistoryView: View {
    @ObservedObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    @State var workoutsHistory: [CompletedWorkout]
    @State private var selectedWorkouts: Set<Workout> = []
    @State private var showFilterSheet = false

    init(appState: AppState, preSelectedWorkout: Workout? = nil) {
        self.appState = appState
        self._workoutsHistory = State(initialValue: appState.getWorkoutsHistory())
        let allWorkouts = Set(self.workoutsHistory.map { $0.workout })
        
        if let preSelectedWorkout = preSelectedWorkout {
            if allWorkouts.contains(where: { $0.id == preSelectedWorkout.id }) {
                self._selectedWorkouts = State(initialValue: Set([preSelectedWorkout]))
            } else {
                self._selectedWorkouts = State(initialValue: Set([]))
            }
        } else {
            self._selectedWorkouts = State(initialValue: allWorkouts)
        }
    }
    
    var body: some View {
        Group {
            if workoutsHistory.isEmpty || selectedWorkouts.isEmpty {
                ScrollView {
                    EmptyWorkoutHistoryView()
                }
            } else {
                List {
                    ForEach(groupedWorkoutsByDate(), id: \.date) { group in
                        Section(header: Text(group.date.formatted(.dateTime.month().day().year()))) {
                            ForEach(group.workouts) { workout in
                                HStack {
                                    Text(workout.workout.title)
                                    Spacer()
                                    Text(workout.timestamp, style: .time)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            updateHistory()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
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
                    Text("History")
                        .font(.title)
                        .bold()
                    Spacer()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showFilterSheet = true }) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
        }
        .sheet(isPresented: $showFilterSheet) {
            MultiSelectFilterView(
                workouts: availableWorkouts(),
                selectedWorkouts: $selectedWorkouts
            )
        }
    }
    
    private func updateHistory() {
        workoutsHistory = appState.getWorkoutsHistory()
    }
    
    private func groupedWorkoutsByDate() -> [WorkoutGroup] {
        let selectedIDs = Set(selectedWorkouts.map { $0.id })
        
        let filteredWorkouts = workoutsHistory.filter { completedWorkout in
            let contains = selectedIDs.contains(completedWorkout.workout.id)
            return contains
        }
                
        let groupedDictionary = Dictionary(grouping: filteredWorkouts) { workout in
            Calendar.current.startOfDay(for: workout.timestamp)
        }
        
        let result = groupedDictionary.map { (key, value) in
            WorkoutGroup(date: key, workouts: value.sorted(by: { $0.timestamp > $1.timestamp }))
        }.sorted(by: { $0.date > $1.date })
                
        return result
    }
    
    private func availableWorkouts() -> [Workout] {
        let result = Array(Set(workoutsHistory.map { $0.workout })).sorted(by: { $0.title < $1.title })
        return result
    }
}


struct WorkoutHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutHistoryView(appState: AppState())
        }
    }
}
