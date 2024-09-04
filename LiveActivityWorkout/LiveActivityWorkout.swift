//
//  LiveActivityWorkout.swift
//  LiveActivityWorkout
//
//  Created by Leon Grimmeisen on 04.09.24.
//

import WidgetKit
import ActivityKit
import SwiftUI

//struct WorkoutLiveActivityView: View {
//    let context: ActivityViewContext<WorkoutAttributes>
//    
//    var body: some View {
//        VStack {
//            Text(context.attributes.workoutName)
//                .font(.headline)
//            Text("Round: \(context.state.currentRound)")
//            Text(context.state.isWorkPhase ? "Work" : "Rest")
//            TimelineView(.animation) { timeline in
//                let elapsedTime = timeline.date.timeIntervalSince(context.state.startTime)
//                let remainingTime = max(context.state.totalDuration - elapsedTime, 0)
//                Text(timeString(from: remainingTime))
//            }
//            Text("Started at: \(formattedTime(context.state.startTime))")
//            Text("Current time: \(formattedTime(Date()))")
//        }
//    }
//    
//    func timeString(from timeInterval: TimeInterval) -> String {
//        let minutes = Int(timeInterval) / 60
//        let seconds = Int(timeInterval) % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    func formattedTime(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        return formatter.string(from: date)
//    }
//}
//
//struct LiveActivityWorkout: Widget {
//    let kind: String = "LiveActivityWorkout"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//                LiveActivityWorkoutEntryView(entry: entry)
//                    .padding()
//                    .background()
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}

//#Preview(as: .systemSmall) {
//    LiveActivityWorkout()
//} timeline: {
//    SimpleEntry(date: .now, emoji: "😀")
//    SimpleEntry(date: .now, emoji: "🤩")
//}
