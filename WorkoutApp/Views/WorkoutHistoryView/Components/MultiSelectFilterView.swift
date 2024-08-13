//
//  MultiSelectFilterView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 09.08.24.
//

import SwiftUI


struct MultiSelectFilterView: View {
    let workouts: [Workout]
    @Binding var selectedWorkouts: Set<Workout>
    @Environment(\.dismiss) private var dismiss
    
    private var allSelected: Bool {
        return selectedWorkouts.count == workouts.count
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    workoutToggleView(for: workout)
                }
                .listRowBackground(Color(UIColor.systemGray5))
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Filter Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    selectDeselectAllButton
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func workoutToggleView(for workout: Workout) -> some View {
        WorkoutToggle(
            workout: workout,
            isSelected: selectedWorkouts.contains(where: { $0.id == workout.id }),
            onToggle: { isSelected in
                if isSelected {
                    selectedWorkouts.insert(workout)
                } else {
                    if let index = selectedWorkouts.firstIndex(where: { $0.id == workout.id }) {
                        selectedWorkouts.remove(at: index)
                    }
                }
            }
        )
    }
    
    private var selectDeselectAllButton: some View {
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
    
}


struct WorkoutToggle: View {
    let workout: Workout
    let isSelected: Bool
    let onToggle: (Bool) -> Void
    
    var body: some View {
        Button {
            onToggle(!isSelected)
        } label: {
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
