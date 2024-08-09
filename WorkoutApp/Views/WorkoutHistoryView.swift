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
        self.workoutsHistory = appState.getWorkoutsHistory()
        let allWorkouts = Set(self.workoutsHistory.map { $0.workout })
        
        if preSelectedWorkout == nil {
            _selectedWorkouts = State(initialValue: allWorkouts)
        } else {
            if workoutsHistory.contains(where: { $0.id == preSelectedWorkout?.id}) {
                _selectedWorkouts = State(initialValue: Set([preSelectedWorkout!]))
            }
        }
    }
    
    func updateHistory() {
        workoutsHistory = appState.getWorkoutsHistory()
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
                                WorkoutRow(workout: workout)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("History")
        .toolbar {
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
        .onAppear {
            updateHistory()
        }
    }
    
    private func groupedWorkoutsByDate() -> [WorkoutGroup] {
        let filteredWorkouts = workoutsHistory.filter { selectedWorkouts.contains($0.workout) }
        let groupedDictionary = Dictionary(grouping: filteredWorkouts) { workout in
            Calendar.current.startOfDay(for: workout.timestamp)
        }
        
        return groupedDictionary.map { (key, value) in
            WorkoutGroup(date: key, workouts: value.sorted(by: { $0.timestamp > $1.timestamp }))
        }.sorted(by: { $0.date > $1.date })
    }
    
    private func availableWorkouts() -> [Workout] {
        Array(Set(workoutsHistory.map { $0.workout })).sorted(by: { $0.title < $1.title })
    }
}

struct EmptyWorkoutHistoryView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "clipboard")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("No Workouts Found")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Adjust your filters or complete a workout to see your history!")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding(20)
        .padding(.top, 40)
    }
}

struct WorkoutRow: View {
    let workout: CompletedWorkout
    
    var body: some View {
        HStack {
            Text(workout.workout.title)
            Spacer()
            Text(workout.timestamp, style: .time)
        }
    }
}

struct WorkoutGroup: Identifiable {
    let id = UUID()
    let date: Date
    let workouts: [CompletedWorkout]
}

struct MultiSelectFilterView: View {
    let workouts: [Workout]
    @Binding var selectedWorkouts: Set<Workout>
    @Environment(\.dismiss) private var dismiss
    
    private var allSelected: Bool {
        selectedWorkouts.count == workouts.count
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    WorkoutToggle(
                        workout: workout,
                        isSelected: selectedWorkouts.contains(workout)
                    ) { isOn in
                        if isOn {
                            selectedWorkouts.insert(workout)
                        } else {
                            selectedWorkouts.remove(workout)
                        }
                    }
                }
            }
            .navigationTitle("Filter Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if allSelected {
                            selectedWorkouts.removeAll()
                        } else {
                            selectedWorkouts = Set(workouts)
                        }
                    } label: {
                        Text(allSelected ? "Deselect All" : "Select All")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct WorkoutToggle: View {
    let workout: Workout
    let isSelected: Bool
    let onToggle: (Bool) -> Void
    
    var body: some View {
        Button(action: {
            onToggle(!isSelected)
        }) {
            HStack {
                Text(workout.title)
                    .foregroundColor(.black)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

extension Date {
    var removeTime: Date {
        Calendar.current.startOfDay(for: self)
    }
}

struct WorkoutHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutHistoryView(appState: AppState())
        }
    }
}
