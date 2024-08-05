//
//  ExerciseDetailView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct ExerciseDetailView: View {
    @ObservedObject var viewModel: ExerciseDetailViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack {
                ExerciseSettingsTitleCard(exercise: $viewModel.exercise)
                    .padding(.bottom, 5)
                ExerciseSettingsValueCard(exercise: $viewModel.exercise, value: $viewModel.exercise.duration, type: .exerciseDuration)
                    .padding(.bottom, 5)
                ExerciseSettingsValueCard(exercise: $viewModel.exercise, value: $viewModel.exercise.rest, type: .exerciseRest)
                    .padding(.bottom, 15)
                
                Spacer()
                
                deleteExerciseButton
                    .padding(.bottom, 20)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(viewModel.exercise.title)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(viewModel.exercise.title)")
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.title)
                        .bold()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
        .confirmationDialog(
            "Delete Exercise?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                viewModel.deleteExercise()
                dismiss()
            }
        }
    }
    
    private var deleteExerciseButton: some View {
        Button(action: {
            showDeleteConfirmation = true
        }) {
            Text("Delete Exercise")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
        }
    }
}

struct ExerciseSettingsTitleCard: View {
    
    @Binding var exercise: Exercise

    var body: some View {
        VStack(alignment: .leading) {
            Text("Exercise Title")
                .foregroundColor(.gray)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 7)
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
                .frame(height: 60)
                .overlay(
                    TextField("Exercise Title", text: $exercise.title)
                        .padding(.horizontal)
                        .font(.title2)
                        .fontWeight(.bold)
                )
        }
    }
}

struct ExerciseSettingsValueCard: View {
    //@Binding var workout: Workout
    @Binding var exercise: Exercise
    @Binding var value: Double
    let type: ExerciseSettingsType
    
    @State private var isSheetPresented = false

    var body: some View {
        
        VStack(alignment: .leading) {
            Text(type.rawValue)
                .foregroundColor(.gray)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.leading, 7)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(height: 60)
                    .foregroundColor(.white)
                HStack {
                    Image(systemName: type.icon)
                    Spacer()
                    Text(value.asDigitalMinutes())
                }
                .padding(.horizontal, 20)
                .font(.title)
                .bold()
            }
        }
        .onTapGesture {
            isSheetPresented.toggle()
        }
        .sheet(isPresented: $isSheetPresented) {
            ExerciseSettingsValueSheet(value: $value, settingType: type)
                .presentationDetents([.fraction(0.4)])
        }
    }
}

struct ExerciseSettingsRemoveCard: View {
    
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.red)
                .frame(height: 60)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
                .overlay(
                    HStack {
                        Spacer()
                        Text("Delete Exercise")
                        Spacer()
                    }
                    .padding(.horizontal)
                    .font(.title2)
                    .bold()
                )
        }
        .onTapGesture {
            // delete exercise
        }
        .padding(.vertical, 10)
    }
}

struct ExerciseSettingsValueSheet: View {
    @Binding var value: Double
    let settingType: ExerciseSettingsType
    @Environment(\.dismiss) private var dismiss

    @State private var minutesSelection = 0
    @State private var secondsSelection = 0
    
    let minutesOptions = Array(0...59)
    let secondsOptions = Array(0...59)

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
        }
        .padding(.horizontal)
    }
    
    private func initializeSelections() {
        let totalSeconds = Int(value)
        minutesSelection = totalSeconds / 60
        secondsSelection = totalSeconds % 60
    }
    
    private func updateValue() {
        let newValue = Double(minutesSelection * 60 + secondsSelection)
        value = newValue
    }
}





//struct ExerciseDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var sampleExercise = Exercise(
//            title: "Push-ups",
//            duration: 30,
//            rest: 15
//        )
//        
//        NavigationView {
//            ExerciseDetailView(exercise: $sampleExercise)
//        }
//    }
//}
