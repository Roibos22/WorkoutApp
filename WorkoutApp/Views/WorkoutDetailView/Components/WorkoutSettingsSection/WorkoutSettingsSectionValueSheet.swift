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
    let numberOptions = Array(0...99)

    var body: some View {
        VStack {
            Text("Change Value")
                .font(.title)
                .padding()
            
            pickerView
            
            Button("Done") {
                updateValue()
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .onAppear(perform: initializeSelections)
    }
    
    private var pickerView: some View {
        Group {
            if settingType != .cycles {
                HStack {
                    Picker("Minutes", selection: $minutesSelection) {
                        ForEach(minutesOptions, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                    
                    Picker("Seconds", selection: $secondsSelection) {
                        ForEach(secondsOptions, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 100)
                }
            } else {
                Picker("Number", selection: $numberSelection) {
                    ForEach(numberOptions, id: \.self) { Text("\($0)").tag($0) }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100)
            }
        }
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
            if var firstExercise = workout.exercises.first {
                firstExercise.duration = newValue
                workout.exercises[0] = firstExercise
            } else {
                workout.exercises.append(Exercise(title: "New Exercise", duration: newValue, rest: 0))
            }
        case .exerciseRest:
            if var firstExercise = workout.exercises.first {
                firstExercise.rest = newValue
                workout.exercises[0] = firstExercise
            } else {
                workout.exercises.append(Exercise(title: "New Exercise", duration: 0, rest: newValue))
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

//#Preview {
//    WorkoutSettingsSectionValueSheet()
//}
