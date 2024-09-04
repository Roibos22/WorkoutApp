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
        var endTime: Date
        var startTime: Date
        var activitiyName: String
        var activityDuration: Double
    }
    var workoutEndTime: Date
}

struct ActivityInfo: Codable, Hashable {
    var name: String
    var duration: TimeInterval
}
struct LiveActivityWorkoutLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WorkoutAttributes.self) { context in
            LiveActivityView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.state.activitiyName)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.activitiyName)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text(context.state.activitiyName)
                }
            } compactLeading: {
                Text(context.state.activitiyName)
            } compactTrailing: {
                Text(context.state.activitiyName)
            } minimal: {
                Text(context.state.activitiyName)
            }
        }
    }
    
    func timeString(from timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct LiveActivityView: View {
    let context: ActivityViewContext<WorkoutAttributes>
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "dumbbell.fill")
                        .frame(width: 30)
                    Text(context.state.activitiyName)
                        .font(.title3)
                        .bold()
                }
                
                HStack {
                    Image(systemName: "figure.run")
                        .frame(width: 30)
                    Text(context.state.endTime, style: .timer)
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
                                .frame(width: geometry.size.width * CGFloat(0.2))
                        }
                    }
                    .frame(height: 20)
                    .cornerRadius(15)
                    Spacer()
                    Text(context.state.activitiyName)
                        .font(.title3)
                        .bold()
                }
            }
            .foregroundColor(.black)
            .padding()
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

//extension WorkoutAttributes {
//    fileprivate static var preview: WorkoutAttributes {
//        WorkoutAttributes()
//    }
//}
//
//extension WorkoutAttributes.ContentState {
//    fileprivate static var sampleState: WorkoutAttributes.ContentState {
//        WorkoutAttributes.ContentState(
//            startTime: Date(),
//            elapsedTime: 20,
//            totalDuration: 440,
//            exerciseName: "Exercise 1"
//        )
//    }
//}
