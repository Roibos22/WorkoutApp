//
//  WorkoutDetailViewButtonSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutDetailViewButtonSection: View {
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @EnvironmentObject var appState: AppState
    @State private var workoutActiveViewModel: WorkoutActiveViewModel?
    
    @Environment(\.dismiss) var dismiss
    
    let workoutType: WorkoutType
    
    var body: some View {
        HStack {
            
            // Preview
            NavigationLink {
                WorkoutPreviewView(vm: viewModel)
            } label: {
                buttonLabel(icon: "stopwatch", text: viewModel.workout.duration.asDigitalMinutes())
            }
            
            // Completions and History
            NavigationLink {
                WorkoutHistoryView(appState: appState, preSelectedWorkout: viewModel.workout)
            } label: {
                buttonLabel(icon: "clock.arrow.circlepath", text: "\(viewModel.workout.completions)x")
            }
            
            // Start Workout
            if workoutType == .custom {
                startWorkoutButton
            } else if workoutType == .preset {
                addWorkoutButton
            }
            
        }
    }
    
    private func buttonLabel(icon: String? = nil, color: Color = .blue, text: String?) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 3)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                )
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                }
                if let text = text {
                    Text(text)
                }
            }
            .font(.title3)
            .foregroundColor(.white)
        }
        .frame(height: 60)
    }
    
    private var startWorkoutButton: some View {
        NavigationLink {
            if let workoutActiveViewModel = workoutActiveViewModel {
                WorkoutActiveView(viewModel: workoutActiveViewModel)
            } else {
                Text("Loading...")
            }
        } label: {
            buttonLabel(icon: "play.fill", color: .green, text: nil)
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
    
    private var addWorkoutButton: some View {
        Button {
            viewModel.savePresetWorkout()
            dismiss()
        } label: {
            buttonLabel(icon: "square.and.arrow.down", color: .green, text: nil)
        }
    }
    
}

struct WorkoutDetailViewButtonSection_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        let workout = Workout.defaultWorkouts[0]
        let viewModel = WorkoutDetailViewModel(workout: workout, appState: appState)
        return WorkoutDetailViewButtonSection(viewModel: viewModel, workoutType: .preset)
            .environmentObject(appState)
    }
}
