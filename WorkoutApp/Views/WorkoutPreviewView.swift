//
//  WorkoutPreviewView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 20.12.23.
//

import SwiftUI

import SwiftUI

struct WorkoutPreviewView: View {
    @EnvironmentObject var vm: WorkoutDetailViewModel
    @Environment(\.dismiss) private var dismiss

    let workout: Workout
    let cycleTimeline: [Cycle]
    
    var mainColor: Color { .blue }
    var accentColor: Color { .black }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Text("Activity")
                    Spacer()
                    Text("Duration (Start Time)")
                }
                .bold()
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                
                Divider()
                
                TimelineListView(cycleTimeline: cycleTimeline, mainColor: mainColor, accentColor: accentColor)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .bold()
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Preview")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                }
            }
        }
    }
}

struct TimelineListView: View {
    let cycleTimeline: [Cycle]
    let mainColor: Color
    let accentColor: Color
    
    var body: some View {
        List {
            ForEach(cycleTimeline, id: \.self) { cycle in
                Section {
                    ForEach(cycle.activities, id: \.self) { activity in
                        ActivityRow(activity: activity)
                    }
                    //.padding(.horizontal)
                } header: {
                    CycleHeader(cycle: cycle, accentColor: accentColor)
                }
                .listRowSeparator(.hidden)
            }
            //.padding(.top)
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
}

struct ActivityRow: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            Image(systemName: activity.type == .exercise ? "dumbbell.fill" : "hourglass")
                .frame(width: 20)
            Text(activity.title)
            Spacer()
            Text("\(activity.duration.asSeconds()) (\(activity.startingTime.asDigitalMinutes()))")
        }
    }
}

struct CycleHeader: View {
    let cycle: Cycle
    let accentColor: Color
    
    var body: some View {
        if cycle.cycleNumber >= 1 {
            HStack {
                Spacer()
                Text("\(cycle.cycleNumber). Cycle")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .foregroundColor(accentColor)
            //.padding(.top, 10)
        }
    }
}

struct WorkoutPreviewView_Previews: PreviewProvider {
    static let appState = AppState()
    static let vm = WorkoutDetailViewModel(appState: appState)
    static var previews: some View {
        WorkoutPreviewView(workout: Workout.sampleWorkouts[0], cycleTimeline: appState.createCycleimeline(workout: Workout.sampleWorkouts[0]))
            .environmentObject(vm)
    }
}
