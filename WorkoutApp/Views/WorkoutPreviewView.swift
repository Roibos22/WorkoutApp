//
//  WorkoutPreviewView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 20.12.23.
//

import SwiftUI

struct WorkoutPreviewView: View {
    @ObservedObject var viewModel: WorkoutDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    let workout: Workout
    let cycleTimeline: [Cycle]
    
    init(vm: WorkoutDetailViewModel) {
        self.viewModel = vm
        self.workout = vm.workout
        self.cycleTimeline = vm.createCycleTimeline()
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Activity")
                Spacer()
                Text("Duration (Start Time)")
            }
            .bold()
            .padding(.horizontal, 25)
            .padding(.bottom, 5)

            Divider()
            
            TimelineListView(cycleTimeline: cycleTimeline)
        }
        .padding(.top, 10)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .bold()
                        Text("Preview")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.black)
                        Spacer()
                    }
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
            }
            .listRowBackground(Color(UIColor.systemGray5))
            .listRowSeparator(.hidden)
        }
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
                    .foregroundColor(.black)
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
        NavigationView {
            WorkoutPreviewView(vm: vm)
                .environmentObject(vm)
        }
    }
}
