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
        VStack(alignment: .leading) {
            sectionHeader
                .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                Text("Edit Cycle Settings")
                    .bold()
                    .padding(.bottom, 1)
                HStack {
                    settingsCard(title: "Cycles", icon: "repeat", settingType: .cycles)
                    settingsCard(title: "Cycle Rest", icon: "hourglass", settingType: .cycleRest)
                }
            }
            .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                Text("Edit Duration for all Exercises")
                    .bold()
                    .padding(.bottom, 1)
                HStack {
                    settingsCard(title: "Exercise Duration", icon: "stopwatch", settingType: .exerciseDuration)
                    settingsCard(title: "Exercise Rest", icon: "hourglass", settingType: .exerciseRest)
                }
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
            .contentShape(Rectangle())
    }
}

struct WorkoutSettingsSection_Previews: PreviewProvider {
    static var previews: some View {
        @State var sampleWorkout = Workout.defaultWorkouts[0]
        
        WorkoutSettingsSection(workout: $sampleWorkout)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Light Mode")
    }
}
