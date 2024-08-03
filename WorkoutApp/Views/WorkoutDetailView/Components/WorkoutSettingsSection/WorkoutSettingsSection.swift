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
                settingsCard(title: "Exercise Duration", icon: "stopwatch", settingType: .exerciseDuration)
                settingsCard(title: "Exercise Rest", icon: "hourglass.circle", settingType: .exerciseRest)
                settingsCard(title: "Cycles", icon: "repeat", settingType: .cycles)
                settingsCard(title: "Cycle Rest", icon: "hourglass.circle", settingType: .cycleRest)
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
    
    private func settingsCard(title: String, icon: String, settingType: WorkoutSettingsType) -> some View {
        WorkoutSettingsSectionCard(title: title, icon: icon, workout: $workout, settingType: settingType)
    }
}
