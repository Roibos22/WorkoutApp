//
//  WorkoutSettingsSectionCard.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import SwiftUI

struct WorkoutSettingsSectionCard: View {
    let title: String
    let icon: String
    @Binding var workout: Workout
    let settingType: WorkoutSettingsType
    
    @State private var isSheetPresented = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
//            Text(title)
//                .foregroundColor(.gray)
//                .font(.subheadline)
//                .fontWeight(.semibold)
//                .padding(.leading, 7)
            
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2)
                .frame(height: 50)
                .overlay(
                    HStack {
                        Image(systemName: icon)
                        Spacer()
                        valueText
                    }
                    .padding(.horizontal)
                    .font(.title2)
                    .fontWeight(.bold)
                )
        }
        .onTapGesture {
            isSheetPresented.toggle()
        }
        .sheet(isPresented: $isSheetPresented) {
            WorkoutSettingsSectionValueSheet(workout: $workout, settingType: settingType)
                .presentationDetents([.fraction(0.4)])
        }
    }
    
    private var valueText: some View {
        Group {
            switch settingType {
            case .exerciseDuration, .exerciseRest, .cycleRest:
                Text(getValue().asDigitalMinutes())
            case .cycles:
                Text("\(Int(getValue()))")
            }
        }
    }
    
    private func getValue() -> Double {
        switch settingType {
        case .exerciseDuration:
            return workout.exercises.first?.duration ?? 0
        case .exerciseRest:
            return workout.exercises.first?.rest ?? 0
        case .cycles:
            return Double(workout.cycles)
        case .cycleRest:
            return workout.cycleRestTime
        }
    }
}

struct WorkoutSettingsSectionCard_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample workout
        @State var sampleWorkout = Workout.sampleWorkouts[0]
        
        return Group {
            // Preview for Exercise Duration
            WorkoutSettingsSectionCard(
                title: "Exercise Duration",
                icon: "stopwatch",
                workout: $sampleWorkout,
                settingType: .exerciseDuration
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(width: 200)
            
            // Preview for Cycles
            WorkoutSettingsSectionCard(
                title: "Cycles",
                icon: "repeat",
                workout: $sampleWorkout,
                settingType: .cycles
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(width: 200)
            
            // Preview for Cycle Rest
            WorkoutSettingsSectionCard(
                title: "Cycle Rest",
                icon: "hourglass",
                workout: $sampleWorkout,
                settingType: .cycleRest
            )
            .previewLayout(.sizeThatFits)
            .padding()
            .frame(width: 200)
        }
    }
}
