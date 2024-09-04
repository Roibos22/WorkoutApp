//
//  LiveActivityWorkoutLiveActivity.swift
//  LiveActivityWorkout
//
//  Created by Leon Grimmeisen on 04.09.24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WorkoutAttributes: ActivityAttributes {
    struct ContentState: Codable, Hashable {
        var startTime: Date
        var elapsedTime: TimeInterval
        var totalDuration: TimeInterval
        var exerciseName: String
    }
}

struct LiveActivityWorkoutLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WorkoutAttributes.self) { context in
            // Lock screen/banner UI goes here
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.blue)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "dumbbell.fill")
                        Text(context.state.exerciseName)
                            .font(.headline)
                    }
                    
                    HStack {
                        Image(systemName: "figure.run")
                        Text(timeString(from: context.state.elapsedTime))
                            .font(.system(size: 20, weight: .bold, design: .monospaced))
                    }
        
                    
                    HStack {
                        ProgressView(value: context.state.elapsedTime, total: context.state.totalDuration)
                            .tint(.white)
                        Spacer()
                        Text(timeString(from: context.state.totalDuration))
                            .font(.caption)
                    }
                }
                .foregroundColor(.white)
                .padding()
            }
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.state.exerciseName)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(timeString(from: context.state.elapsedTime))
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ProgressView(value: context.state.elapsedTime, total: context.state.totalDuration)
                }
            } compactLeading: {
                Text(context.state.exerciseName)
            } compactTrailing: {
                Text(timeString(from: context.state.elapsedTime))
            } minimal: {
                Text(timeString(from: context.state.elapsedTime))
            }
        }
    }
    
    func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

//#Preview("Notification", as: .content, using: WorkoutAttributes.preview) {
//   LiveActivityWorkoutLiveActivity()
//} contentStates: {
//    WorkoutAttributes.ContentState.sampleState
//}
//
//extension WorkoutAttributes {
//    fileprivate static var preview: WorkoutAttributes {
//        WorkoutAttributes()
//    }
//}

extension WorkoutAttributes.ContentState {
    fileprivate static var sampleState: WorkoutAttributes.ContentState {
        WorkoutAttributes.ContentState(
            startTime: Date(),
            elapsedTime: 20,
            totalDuration: 440,
            exerciseName: "Exercise 1"
        )
    }
}
