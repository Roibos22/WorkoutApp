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
                            .frame(width: 30)
                        Text(context.state.exerciseName)
                            .font(.title3)
                            .bold()
                    }
                    
                    HStack {
                        Image(systemName: "figure.run")
                            .frame(width: 30)
                        Text(timeString(from: context.state.elapsedTime))
                            .font(.title3)
                            .bold()
                    }
        
                    
                    HStack {
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 8)
                                Rectangle()
                                    .fill(Color.black)
                                    .frame(width: geometry.size.width * 0.4)
                            }
                        }
                        .frame(height: 20)
                        .cornerRadius(15)
                        Spacer()
                        Text(timeString(from: context.state.totalDuration))
                            .font(.title3)
                            .bold()
                    }
                }
                .foregroundColor(.black)
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

extension WorkoutAttributes {
    fileprivate static var preview: WorkoutAttributes {
        WorkoutAttributes()
    }
}

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
