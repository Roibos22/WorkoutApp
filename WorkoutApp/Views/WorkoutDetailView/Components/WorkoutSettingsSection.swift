import SwiftUI

struct WorkoutSettingsSection: View {
    @Binding var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            sectionHeader
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                settingsCard(title: "Exercise Duration", icon: "stopwatch", value: exerciseDurationBinding, format: .asMinutes)
                settingsCard(title: "Exercise Rest", icon: "hourglass.circle", value: exerciseRestBinding, format: .asMinutes)
                settingsCard(title: "Cycles", icon: "repeat", value: cyclesBinding, format: .asNumber)
                settingsCard(title: "Cycle Rest", icon: "hourglass.circle", value: $workout.cycleRestTime, format: .asMinutes)
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
    
    private func settingsCard(title: String, icon: String, value: Binding<Double>, format: WorkoutSettingsCardFormats) -> some View {
        WorkoutSettingsCard(title: title, icon: icon, value: value, format: format)
    }
    
    private var exerciseDurationBinding: Binding<Double> {
        Binding(
            get: { self.workout.exercises.first?.duration ?? 0 },
            set: { newValue in
                if var firstExercise = self.workout.exercises.first {
                    firstExercise.duration = newValue
                    self.workout.exercises[0] = firstExercise
                } else {
                    self.workout.exercises.append(Exercise(title: "New Exercise", duration: newValue, rest: 0))
                }
            }
        )
    }
    
    private var exerciseRestBinding: Binding<Double> {
        Binding(
            get: { self.workout.exercises.first?.rest ?? 0 },
            set: { newValue in
                if var firstExercise = self.workout.exercises.first {
                    firstExercise.rest = newValue
                    self.workout.exercises[0] = firstExercise
                } else {
                    self.workout.exercises.append(Exercise(title: "New Exercise", duration: 0, rest: newValue))
                }
            }
        )
    }
    
    private var cyclesBinding: Binding<Double> {
        Binding(
            get: { Double(self.workout.cycles) },
            set: { self.workout.cycles = Int($0) }
        )
    }
}

struct WorkoutSettingsCard: View {
    let title: String
    let icon: String
    @Binding var value: Double
    let format: WorkoutSettingsCardFormats
    
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
            SheetView(value: $value, format: format)
                .presentationDetents([.fraction(0.3)])
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
    }
}

struct SheetView: View {
    @Binding var value: Double
    let format: WorkoutSettingsCardFormats
    @Environment(\.dismiss) private var dismiss

    @State private var minutesSelection = 0
    @State private var secondsSelection = 0
    @State private var numberSelection = 0
    
    let minutesOptions = Array(0...59)
    let secondsOptions = Array(0...59)
    let numberOptions = Array(0...100)

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
            if format == .asMinutes {
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
        if format == .asMinutes {
            let totalSeconds = Int(value)
            minutesSelection = totalSeconds / 60
            secondsSelection = totalSeconds % 60
        } else {
            numberSelection = Int(value)
        }
    }
    
    private func updateValue() {
        if format == .asMinutes {
            value = Double(minutesSelection * 60 + secondsSelection)
        } else {
            value = Double(numberSelection)
        }
    }
}

enum WorkoutSettingsCardFormats {
    case asMinutes
    case asNumber
}
