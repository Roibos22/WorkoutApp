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
        .onTapGesture {
            isSheetPresented.toggle()
        }
        .sheet(isPresented: $isSheetPresented) {
            WorkoutSettingsSectionValueSheet(workout: $workout, settingType: settingType)
                .presentationDetents([.fraction(0.3)])
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

//#Preview {
//    WorkoutSettingsSectionCard()
//}
