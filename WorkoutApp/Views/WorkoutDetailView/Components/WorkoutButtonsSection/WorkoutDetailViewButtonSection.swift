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
    
//    var activitiesTimeline: [Activity] {
//        appState.timelineService.createWorkoutTimeline(workout: viewModel.workout)
//    }
    
    var body: some View {
        HStack {
            // Preview
            NavigationLink {
                // TODO: Implement Preview View
                WorkoutPreviewView(vm: viewModel)
            } label: {
                buttonLabel(icon: "clock.fill", text: viewModel.workout.duration.asDigitalMinutes())
            }
            
            // Completions and History
            NavigationLink {
                // TODO: Implement WorkoutHistoryView
                Text("Workout History")
            } label: {
                buttonLabel(icon: "clock.arrow.circlepath", text: "\(viewModel.completions)x")
            }
            
            // Start Workout
            NavigationLink {
                if let workoutActiveViewModel = workoutActiveViewModel {
                    WorkoutActiveView(viewModel: workoutActiveViewModel)
                } else {
                    Text("Loading...")
                }
            } label: {
                buttonLabel(text: "GO!")
            }
            .simultaneousGesture(TapGesture().onEnded {
                if workoutActiveViewModel == nil {
                    workoutActiveViewModel = WorkoutActiveViewModel(
                        workout: viewModel.workout,
                        workoutTimeline: appState.createWorkoutTimeline(workout: viewModel.workout),
                        appState: appState
                    )
                }
                workoutActiveViewModel?.isRunning = true
            })
        }
        .onAppear {
            viewModel.updateCompletions()
        }
    }
    
    private func buttonLabel(icon: String? = nil, text: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue)
                )
                .frame(height: 60)
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                }
                Text(text)
            }
            .font(.title3)
            .bold()
            .foregroundColor(.white)
        }
    }
}

struct WorkoutDetailViewButtonSection_Previews: PreviewProvider {
    static var previews: some View {
        let appState = AppState()
        let workout = Workout.sampleWorkouts[0]
        let viewModel = WorkoutDetailViewModel(workout: workout, appState: appState)
        return WorkoutDetailViewButtonSection(viewModel: viewModel)
            .environmentObject(appState)
    }
}
