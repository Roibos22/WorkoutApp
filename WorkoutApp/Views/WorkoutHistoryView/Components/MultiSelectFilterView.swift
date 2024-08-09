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
