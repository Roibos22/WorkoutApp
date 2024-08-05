//
//  WorkoutActiveView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutActiveView: View {
    @StateObject private var viewModel: WorkoutActiveViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showEndAlert = false

    init(workout: Workout, workoutTimeline: [Activity]) {
        _viewModel = StateObject(wrappedValue: WorkoutActiveViewModel(workout: workout, workoutTimeline: workoutTimeline))
    }

    var body: some View {
        ZStack {
            viewModel.isRestActivity ? Color.black : Color.blue
            
            VStack {
                if viewModel.isFinished {
                    //WorkoutCompletedView(workout: viewModel.workout, workoutTimeline: viewModel.workoutTimeline)
                } else {
                    Spacer()
                    ActivityDisplayView(viewModel: viewModel)
                    Spacer()
                    ProgressCircleView(viewModel: viewModel)
                    Spacer()
                    ProgressBarView(viewModel: viewModel)
                    ControlButtonsView(viewModel: viewModel, showEndAlert: $showEndAlert)
                    Spacer()
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .alert("End Workout", isPresented: $showEndAlert) {
            Button("End Workout") { dismiss() }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to end your workout?")
        }
    }
}

struct WorkoutActiveView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutActiveView(workout: sampleWorkout, workoutTimeline: sampleWorkoutTimeline)
    }
    
    // Sample data for preview
    static var sampleWorkout: Workout = Workout.sampleWorkouts[0]
    static var timelineService = WorkoutTimelineService()
    static var sampleWorkoutTimeline: [Activity] = timelineService.createWorkoutTimeline(workout: sampleWorkout)
}
