//
//  WorkoutDetailViewButtonSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutSettingsSection: View {
    @Binding var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            sectionHeader
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                settingsCard(title: "Cycles", icon: "repeat", settingType: .cycles)
                settingsCard(title: "Cycle Rest", icon: "hourglass.circle", settingType: .cycleRest)
                settingsCard(title: "Exercise Duration", icon: "stopwatch", settingType: .exerciseDuration)
                settingsCard(title: "Exercise Rest", icon: "hourglass.circle", settingType: .exerciseRest)
            }
        }
        //.padding()
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
    
    private func settingsCard(title: String, icon: String, settingType: WorkoutSettingsType) -> some View {
        WorkoutSettingsSectionCard(title: title, icon: icon, workout: $workout, settingType: settingType)
    }
}

struct WorkoutSettingsSection_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample workout
        @State static var sampleWorkout = Workout.sampleWorkouts[0]
        
        return Group {
            // Light mode preview
            WorkoutSettingsSection(workout: $sampleWorkout)
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Light Mode")
            
            // Dark mode preview
            WorkoutSettingsSection(workout: $sampleWorkout)
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
            
            // iPhone SE preview for smaller screens
            WorkoutSettingsSection(workout: $sampleWorkout)
                .previewDevice("iPhone SE (3rd generation)")
                .previewDisplayName("iPhone SE")
        }
    }
}
