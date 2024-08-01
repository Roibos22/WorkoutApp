//
//  WorkoutPreviewView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 20.12.23.
//

import SwiftUI

struct WorkoutPreviewView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) private var dismiss

    let workout: Workout
    let cycleTimeline: [Cycle]
    
    var mainColor: Color { .blue }
    var accentColor: Color { .black }
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .top) {
                // Header Section
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(workout.title)")
                            .font(.title)
                            .bold()
                        HStack() {
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "clock.fill")
                                    //Text("\(tabataTimeLeft.asMinutes())")
                                }
                                
                                HStack {
                                    Image(systemName: "bolt.circle.fill")
                                    //Text("\(totalExercises) Exercises")
                                }
                            }
                            .bold()
                            .font(.callout)
                            .foregroundColor(accentColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 1)
                        }
                    }
                }
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading, 20)
                Spacer()
                // Dismiss Buttons
                VStack() {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(mainColor)
                    }
                    .padding(.trailing, 20)
                }
            }
            .padding(.top, 20)
            
            Divider()
            
            
            // Timeline
            List {
                ForEach(cycleTimeline, id: \.self) { cycle in
                    Section {
                        ForEach(cycle.activities, id: \.self) { activity in
                            HStack {
                                Text(activity.title)
                                Spacer()
                                Text("\(activity.duration.asSeconds()) (\(activity.startingTime.asMinutes()))")
                            }
                        }
                    } header: {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    if cycle.cycleNumber >= 1 {
                                        VStack {
                                            Text("Cycle \(cycle.cycleNumber)")
                                                .font(.headline)
                                                .bold()
                                            Spacer()
                                        }
                                    }
                                }
                                HStack {
                                    Text("Activity")
                                    Spacer()
                                    Text("Duration (Start Time)")
                                }
                                .fixedSize(horizontal: false, vertical: true)
                            }
                            .foregroundColor(accentColor)
                        }
                    }
                    .bold()
                    .listRowBackground(mainColor)
                    .listRowSeparatorTint(accentColor)
                    .foregroundColor(accentColor)
                }

            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct WorkoutPreviewView_Previews: PreviewProvider {
    static let vm = ViewModel()
    static var previews: some View {
        WorkoutPreviewView(workout: Workout.sampleWorkouts[0], cycleTimeline: vm.getCycleTimeline(workout: Workout.sampleWorkouts[0]))
            .environmentObject(vm)
    }
}
