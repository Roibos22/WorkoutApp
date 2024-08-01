//
//  ExerciseDetailView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

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
                Text("Remove Exercise")
                Spacer()
            }
            .padding()
            .font(.title2)
            .bold()
        }
        .padding(.vertical, 10)

    }
}

struct ExerciseSettingsTitleCard: View {
    
    let exercise: Exercise
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("Exercise Title")
                .offset(x: 15, y: -43)
                .foregroundColor(.gray)
                .bold()
                .font(.subheadline)
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
                .frame(height: 60)
                .foregroundColor(.white)
            HStack {
                Text("Exercise Title")
            }
            .padding()
            .font(.title)
            .bold()
        }
        .padding(.vertical, 10)
    }
}

struct ExerciseSettingsValueCard: View {
    
    let exercise: Exercise
    let title: String
    let icon: String
    let value: Double
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .offset(x: 15, y: -43)
                .foregroundColor(.gray)
                .bold()
                .font(.subheadline)
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
                .frame(height: 60)
                .foregroundColor(.white)
            HStack {
                Image(systemName: icon)
                Spacer()
                Text(value.asDigitalMinutes())
            }
            .padding()
            .font(.title)
            .bold()
        }
        .padding(.vertical, 10)
    }
}

struct ExerciseDetailView: View {
    
    let exercise: Exercise
    
    var body: some View {
        ScrollView {
            VStack {
                ExerciseSettingsTitleCard(exercise: exercise)
                ExerciseSettingsValueCard(exercise: exercise, title: "Exercise Duration", icon: "stopwatch", value: exercise.duration)
                ExerciseSettingsValueCard(exercise: exercise, title: "Exercise Rest", icon: "hourglass", value: exercise.rest)
                ExerciseSettingsRemoveCard(exercise: exercise)
            }
            .padding()
            .navigationTitle(exercise.title)
        }
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: Workout.sampleWorkouts[0].exercises[0])
    }
}
