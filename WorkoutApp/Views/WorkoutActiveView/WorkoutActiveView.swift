//
//  WorkoutActiveView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct ExerciseDisplayView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WorkoutProgressCircleView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WorkoutProgressBarView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WorkoutActiveView: View {
    
    let workout: Workout
    
    var body: some View {
        VStack {
            Spacer()
            ExerciseDisplayView()
            Spacer()
            WorkoutProgressCircleView()
            Spacer()
            WorkoutProgressBarView()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct WorkoutActiveView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutActiveView(workout: Workout.sampleWorkouts[0])
    }
}
