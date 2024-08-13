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
                        selectedWorkouts: $selectedWorkouts,
                        isSelected:  selectedWorkouts.contains(where: { $0.id == workout.id })
                    )
                }
                .listRowBackground(Color(UIColor.systemGray5))
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
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
    @Binding var selectedWorkouts: Set<Workout>
    @State var isSelected: Bool
    
    var body: some View {
        Button {
            if let index = selectedWorkouts.firstIndex(where: { $0.id == workout.id }) {
                selectedWorkouts.remove(at: index)
            } else {
                selectedWorkouts.insert(workout)
            }
            isSelected.toggle()
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
