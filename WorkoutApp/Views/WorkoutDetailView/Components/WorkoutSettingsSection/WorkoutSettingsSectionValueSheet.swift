//
//  WorkoutSettingsSectionValueSheet.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 03.08.24.
//

import SwiftUI

struct WorkoutSettingsSectionValueSheet: View {
    @Binding var workout: Workout
    let settingType: WorkoutSettingsType
    @Environment(\.dismiss) private var dismiss

    @State private var minutesSelection = 0
    @State private var secondsSelection = 0
    @State private var numberSelection = 0
    
    let minutesOptions = Array(0...59)
    let secondsOptions = Array(0...59)
    let numberOptions = Array(1...99)

    var body: some View {
        VStack {
            Text("\(settingType.changeValueString)")
                .bold()
                .font(.title3)
                .padding(.top, 25)
            
            pickerView
            
            Button("Save") {
                updateValue()
                dismiss()
            }
            .padding(.bottom)
            .font(.title3)
            .foregroundColor(.blue)
            .cornerRadius(10)
        }
        .onAppear(perform: initializeSelections)
    }
    
    private var pickerView: some View {
        Group {
            if settingType != .cycles {
                HStack {
                    Picker("Minutes", selection: $minutesSelection) {
                        ForEach(minutesOptions, id: \.self) { Text("\($0) min").tag($0) }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Picker("Seconds", selection: $secondsSelection) {
                        ForEach(secondsOptions, id: \.self) { Text("\($0) sec").tag($0) }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            } else {
                Picker("Number", selection: $numberSelection) {
                    ForEach(numberOptions, id: \.self) { Text("\($0)").tag($0) }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100)
            }
        }
        .padding(.horizontal)
    }
    
    private func initializeSelections() {
        let value = getValue()
        if settingType != .cycles {
            let totalSeconds = Int(value)
            minutesSelection = totalSeconds / 60
            secondsSelection = totalSeconds % 60
        } else {
            numberSelection = Int(value)
        }
    }
    
    private func updateValue() {
        let newValue: Double
        if settingType != .cycles {
            newValue = Double(minutesSelection * 60 + secondsSelection)
        } else {
            newValue = Double(numberSelection)
        }
        
        switch settingType {
        case .exerciseDuration:
            workout.exercises.forEach { exercise in
                workout.exercises[workout.exercises.firstIndex(of: exercise)!].duration = newValue
            }
        case .exerciseRest:
            workout.exercises.forEach { exercise in
                    workout.exercises[workout.exercises.firstIndex(of: exercise)!].rest = newValue
            }
        case .cycles:
            workout.cycles = Int(newValue)
        case .cycleRest:
            workout.cycleRestTime = newValue
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

#Preview {
    @State var sampleWorkout = Workout.sampleWorkouts[0]
    
    return WorkoutSettingsSectionValueSheet(
        workout: $sampleWorkout,
        settingType: .exerciseDuration
    )
}
