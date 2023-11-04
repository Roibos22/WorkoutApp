//
//  WorkoutActiveView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct WorkoutActiveView: View {
    
    let workout: Workout
    let workoutTimeline: [Activity]
    
    @State private var isRestActivity: Bool = false
    @State private var circleProgress: Double = 0.9
    
    var currentActivity: Activity { workoutTimeline[activityCount] }
    @State private var activityCount: Int = 0

    var body: some View {
        VStack {
            
            Spacer()
            
            // running activity & next activity
            
            VStack {
                
                // running activity
                Text(currentActivity.title)
                    .font(.title)
                    .bold()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                isRestActivity ? .blue : .black,
                                lineWidth: 10
                            )
                            .frame(width: UIScreen.screenWidth * 0.8)
                            .frame(minHeight: 60)
                    )
                    .frame(minHeight: 70)

                // next activity
                HStack {
                    Text("Next:")
                    if activityCount - 1 < workoutTimeline.count {
                        Text("\(workoutTimeline[activityCount + 1].title)")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .foregroundColor(isRestActivity ? .blue : .black)
                .font(.title2)
            }
            
            Spacer()
            
            // progress circle
            ZStack {
                Circle()
                    .trim(from: 0, to: circleProgress)
                    .stroke(
                        isRestActivity ? .blue : .black,
                        style: StrokeStyle(
                            lineWidth: 30,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: circleProgress)
            }
            .padding(.horizontal, 20)
            
            Spacer()

//            ForEach(workoutTimeline) { activity in
//                HStack {
//                    Text(activity.title)
//                    Text("\(activity.duration)")
//                }
//            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.blue)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct WorkoutActiveView_Previews: PreviewProvider {
    static let vm = ViewModel()
    static var previews: some View {
        WorkoutActiveView(workout: Workout.sampleWorkouts[0], workoutTimeline: vm.getWorkoutTimeline(workout: Workout.sampleWorkouts[0]))
    }
}
