//
//  WorkoutSettingsSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 06.10.23.
//

import SwiftUI

struct WorkoutSettingsSection: View {
    @Binding var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            sectionHeader
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                settingsCard(title: "Exercise Duration", icon: "stopwatch", value: workout.exercises.first?.duration ?? 0, format: .asMinutes)
                settingsCard(title: "Exercise Rest", icon: "hourglass.circle", value: workout.exercises.first?.rest ?? 0, format: .asMinutes)
                settingsCard(title: "Cycles", icon: "repeat", value: Double(workout.cycles), format: .asNumber)
                settingsCard(title: "Cycle Rest", icon: "hourglass.circle", value: workout.cycleRestTime, format: .asMinutes)
            }
        }
        .padding()
    }
    
    private var sectionHeader: some View {
        HStack {
            Image(systemName: "dumbbell.fill")
            Text("Workout Settings")
            Spacer()
        }
        .font(.title2)
        .fontWeight(.bold)
    }
    
    private func settingsCard(title: String, icon: String, value: Double, format: WorkoutSettingsCardFormats) -> some View {
        WorkoutSettingsCard(title: title, icon: icon, value: .constant(value), format: format)
    }
}

struct WorkoutSettingsCard: View {
    let title: String
    let icon: String
    @Binding var value: Double
    let format: WorkoutSettingsCardFormats
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .foregroundColor(.gray)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .frame(height: 60)
                .overlay(
                    HStack {
                        Image(systemName: icon)
                        Spacer()
                        valueText
                    }
                    .padding(.horizontal)
                    .font(.title3)
                    .fontWeight(.bold)
                )
        }
    }
    
    private var valueText: some View {
        Group {
            switch format {
            case .asMinutes:
                Text(value.asDigitalMinutes())
            case .asNumber:
                Text("\(Int(value))")
            }
        }
        .onTapGesture {
            // Here you could present a picker or other input method to change the value
        }
    }
}

enum WorkoutSettingsCardFormats {
    case asMinutes
    case asNumber
}

// Preview
struct WorkoutSettingsSection_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingsSection(workout: .constant(Workout.sampleWorkouts[0]))
    }
}

