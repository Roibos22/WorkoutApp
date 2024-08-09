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
    @State private var refreshToggle = false  // Add this line

    init(appState: AppState, preSelectedWorkout: Workout? = nil) {
        self.appState = appState
        self._workoutsHistory = State(initialValue: appState.getWorkoutsHistory())
        let allWorkouts = Set(self.workoutsHistory.map { $0.workout })
        
        print("Init: workoutsHistory count: \(self.workoutsHistory.count)")
        print("Init: allWorkouts count: \(allWorkouts.count)")
        
        if let preSelectedWorkout = preSelectedWorkout {
            print("\nPre-selected workout ID: \(preSelectedWorkout.id)")
            if allWorkouts.contains(where: { $0.id == preSelectedWorkout.id }) {
                print("Initializing with pre-selected workout: \(preSelectedWorkout.title)")
                self._selectedWorkouts = State(initialValue: Set([preSelectedWorkout]))
            } else {
                print("Pre-selected workout not found, initializing with all workouts")
                self._selectedWorkouts = State(initialValue: allWorkouts)
            }
        } else {
            print("No pre-selected workout, initializing with all workouts")
            self._selectedWorkouts = State(initialValue: allWorkouts)
        }
    }
    
    func updateHistory() {
        workoutsHistory = appState.getWorkoutsHistory()
        print("updateHistory: New workoutsHistory count: \(workoutsHistory.count)")
        refreshToggle.toggle()  // Force view to refresh
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
        .onAppear {
            print("onAppear: workoutsHistory count: \(workoutsHistory.count)")
            print("onAppear: selectedWorkouts count: \(selectedWorkouts.count)")
            selectedWorkouts.forEach { print("onAppear: Selected workout ID: \($0.id)") }
            updateHistory()
        }
        .onChange(of: refreshToggle) { _ in
            print("View refreshed due to refreshToggle change")
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
    
    private func groupedWorkoutsByDate() -> [WorkoutGroup] {
        print("groupedWorkoutsByDate called")
        print("workoutsHistory count: \(workoutsHistory.count)")
        print("selectedWorkouts count: \(selectedWorkouts.count)")
        
        // Debug: Print details of workouts in history
        for (index, completedWorkout) in workoutsHistory.enumerated() {
            print("History Workout \(index):")
            print("  ID: \(completedWorkout.workout.id)")
            print("  Title: \(completedWorkout.workout.title)")
            // Print other relevant properties
        }
        
        // Debug: Print details of selected workouts
        for (index, workout) in selectedWorkouts.enumerated() {
            print("Selected Workout \(index):")
            print("  ID: \(workout.id)")
            print("  Title: \(workout.title)")
            // Print other relevant properties
        }
        
        let filteredWorkouts = workoutsHistory.filter { completedWorkout in
            let contains = selectedWorkouts.contains(completedWorkout.workout)
            print("Checking workout: \(completedWorkout.workout.id) - Contains: \(contains)")
            return contains
        }
        print("filteredWorkouts count: \(filteredWorkouts.count)")
        
        let groupedDictionary = Dictionary(grouping: filteredWorkouts) { workout in
            Calendar.current.startOfDay(for: workout.timestamp)
        }
        
        let result = groupedDictionary.map { (key, value) in
            WorkoutGroup(date: key, workouts: value.sorted(by: { $0.timestamp > $1.timestamp }))
        }.sorted(by: { $0.date > $1.date })
        
        print("groupedWorkoutsByDate result count: \(result.count)")
        return result
    }
    
    private func availableWorkouts() -> [Workout] {
        let result = Array(Set(workoutsHistory.map { $0.workout })).sorted(by: { $0.title < $1.title })
        print("availableWorkouts count: \(result.count)")
        return result
    }
}

extension Workout: Hashable {
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
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
