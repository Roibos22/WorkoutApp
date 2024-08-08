//
//  WorkoutPreviewView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 20.12.23.
//

import SwiftUI

import SwiftUI

struct WorkoutPreviewView: View {
    @EnvironmentObject var vm2: WorkoutDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    let vm: WorkoutDetailViewModel
    let workout: Workout
    let cycleTimeline: [Cycle]
    
    init(vm: WorkoutDetailViewModel) {
        self.vm = vm
        self.workout = vm.workout
        self.cycleTimeline = vm.createCycleTimeline()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Activity")
                Spacer()
                Text("Duration (Start Time)")
            }
            .bold()
            .padding(.horizontal, 20)
            
            Divider()
            
            TimelineListView(cycleTimeline: cycleTimeline)
        }
        .padding(.vertical, 10)
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

struct TimelineListView: View {
    let cycleTimeline: [Cycle]

    var body: some View {
        List {
            ForEach(cycleTimeline, id: \.self) { cycle in
                Section {
                    ForEach(cycle.activities, id: \.self) { activity in
                        ActivityRow(activity: activity)
                    }
                } header: {
                    CycleHeader(cycle: cycle)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

struct ActivityRow: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: activity.type == .exercise ? "dumbbell.fill" : "hourglass")
                Spacer()
            }
            .frame(width: 30)
            Text(activity.title)
            Spacer()
            Text("\(activity.duration.asSeconds()) (\(activity.startingTime.asDigitalMinutes()))")
        }
    }
}

struct CycleHeader: View {
    let cycle: Cycle
    
    var body: some View {
        if cycle.cycleNumber >= 1 {
            HStack {
                Spacer()
                Text("\(cycle.cycleNumber). Cycle")
                    .font(.title3)
                    .bold()
                Spacer()
            }
        }
    }
}

struct WorkoutPreviewView_Previews: PreviewProvider {
    static let appState = AppState()
    static let vm = WorkoutDetailViewModel(appState: appState)
    static var previews: some View {
        //NavigationView {
            WorkoutPreviewView(vm: vm)
                .environmentObject(vm)
        //}
    }
}
