//
//  WorkoutCardView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.10.23.
//

import SwiftUI

// Heights:
// Card: 170
// Title: 45


struct WorkoutCardView: View {
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @EnvironmentObject var appState: AppState
    @State private var workoutActiveViewModel: WorkoutActiveViewModel?
    
    let workout: Workout
    
    var body: some View {
        ZStack(alignment: .top) {
            cardBackground
            VStack(alignment: .leading) {
                titleBar
                HStack {
                    workoutInfo
                    Spacer()
                    playButton
                }
            }
        }
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.black, lineWidth: 4)
            .frame(height: 172)
            .foregroundColor(.white)
    }
    
    private var titleBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 45)
                .foregroundColor(.blue)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 4))
            Text(workout.title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
        }
    }
    
    private var workoutInfo: some View {
        VStack(alignment: .leading) {
            infoRow(icon: "dumbbell.fill", text: "\(workout.exercises.count) Exercises")
            infoRow(icon: "repeat", text: "\(workout.cycles) Cycles")
            infoRow(icon: "clock.fill", text: "\(workout.duration.asMinutes())")
        }
        .padding(.horizontal)
        .font(.title2)
    }
    
    private func infoRow(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 50)
            Text(text)
        }
        .padding(.vertical, 1)
    }
    
    private var playButton: some View {
        NavigationLink {
            if let workoutActiveViewModel = workoutActiveViewModel {
                WorkoutActiveView(viewModel: workoutActiveViewModel)
            } else {
                Text("Loading...")
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 80, height: 40)
                    .foregroundColor(.green)
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
            }
            .padding(.top, 60)
            .padding(.trailing, 15)
        }
        .simultaneousGesture(TapGesture().onEnded {
            workoutActiveViewModel = WorkoutActiveViewModel(
                workoutViewModel: viewModel,
                workout: viewModel.workout,
                workoutTimeline: appState.createWorkoutTimeline(workout: viewModel.workout),
                appState: appState
            )
            workoutActiveViewModel?.isRunning = true
        })
    }
}

struct WorkoutCardView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCardView(viewModel: WorkoutDetailViewModel(appState: AppState()), workout: Workout.sampleWorkouts[0])
    }
}
