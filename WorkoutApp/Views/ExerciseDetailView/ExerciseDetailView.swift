//
//  ExerciseDetailView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct ExerciseDetailView: View {
    
    @Binding var exercise: Exercise

    var body: some View {
        ScrollView {
            VStack {
                ExerciseSettingsTitleCard(exercise: $exercise)
                    .padding(.bottom, 5)
                ExerciseSettingsValueCard(exercise: $exercise, value: $exercise.duration, title: "Exercise Duration", icon: "stopwatch")
                    .padding(.bottom, 5)
                ExerciseSettingsValueCard(exercise: $exercise, value: $exercise.rest, title: "Exercise Rest", icon: "hourglass")
                    .padding(.bottom, 15)
                ExerciseSettingsRemoveCard(exercise: exercise)
                    .padding(.bottom, 5)
            }
            .padding()
            .navigationTitle(exercise.title)
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
    
    @Binding var exercise: Exercise
    @Binding var value: Double
    let title: String
    let icon: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
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
                    Image(systemName: icon)
                    Spacer()
                    Text(value.asDigitalMinutes())
                }
                .padding(.horizontal, 20)
                .font(.title)
                .bold()
            }
        }
    }
}

struct ExerciseSettingsRemoveCard: View {
    
    let exercise: Exercise

    var body: some View {
        ZStack(alignment: .leading) {
            Text("")
                .offset(x: 15, y: -43)
                .foregroundColor(.gray)
                .bold()
                .font(.subheadline)
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.red)
                .frame(height: 60)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
            HStack {
                Spacer()
                Text("Delete Exercise")
                Spacer()
            }
            .padding()
            .font(.title2)
            .bold()
        }
        .padding(.vertical, 10)
    }
}







struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var sampleExercise = Exercise(
            title: "Push-ups",
            duration: 30,
            rest: 15
        )
        
        NavigationView {
            ExerciseDetailView(exercise: $sampleExercise)
        }
    }
}
