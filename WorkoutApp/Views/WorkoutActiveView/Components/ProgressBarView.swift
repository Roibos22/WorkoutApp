//
//  ProgressBarView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 05.08.24.
//

import SwiftUI

struct ProgressBarView: View {
    @ObservedObject var viewModel: WorkoutActiveViewModel

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 15)
                        //.fill(Color.gray.opacity(1))
                        .stroke(viewModel.isRestActivity ? Color.blue : Color.black, lineWidth: 10)
                    Rectangle()
                        .fill(viewModel.isRestActivity ? Color.blue : Color.black)
                        .frame(width: geometry.size.width * viewModel.barProgress)
                }
            }
            .frame(height: 30)
            .cornerRadius(15)
        }
        .foregroundColor(viewModel.isRestActivity ? .blue : .black)
    }
}


struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutActiveView(viewModel: WorkoutActiveViewModel(workoutViewModel: WorkoutDetailViewModel(appState: AppState()), workout: sampleWorkout, workoutTimeline: sampleWorkoutTimeline, appState: AppState()))
    }
    
    // Sample data for preview
    static var sampleWorkout: Workout = Workout.sampleWorkouts[0]
    static var timelineService = WorkoutTimelineService()
    static var sampleWorkoutTimeline: [Activity] = timelineService.createWorkoutTimeline(workout: sampleWorkout)
}
