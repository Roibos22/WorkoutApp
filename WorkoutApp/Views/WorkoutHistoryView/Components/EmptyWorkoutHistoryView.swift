//
//  EmptyWorkoutHistoryView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 09.08.24.
//

import SwiftUI

struct EmptyWorkoutHistoryView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "clipboard")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            
            Text("No Workouts Found")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Adjust your filters or complete a workout to see your history!")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding(20)
        .padding(.top, 40)
    }
}
