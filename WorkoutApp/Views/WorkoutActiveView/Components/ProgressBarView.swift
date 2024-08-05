//
//  ProgressBarView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 05.08.24.
//

import SwiftUI

struct ProgressBarView: View {
    @ObservedObject var viewModel: WorkoutActiveViewModel

    var body: some View {
        VStack {
            HStack {
                Text("Cycle: \(viewModel.currentActivity.cycleNo)/\(viewModel.workout.cycles)")
                Spacer()
                Text("Exercise: \(viewModel.currentActivity.activityNo)/\(viewModel.workout.exercises.count)")
            }
            .font(.headline)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 15)
                        //.fill(Color.gray.opacity(1))
                        .stroke(viewModel.isRestActivity ? Color.blue : Color.black, lineWidth: 7)
                    Rectangle()
                        .fill(viewModel.isRestActivity ? Color.blue : Color.black)
                        .frame(width: geometry.size.width * viewModel.barProgress)
                }
            }
            .frame(height: 25)
            .cornerRadius(15)
        }
        .foregroundColor(viewModel.isRestActivity ? .blue : .black)
    }
}
//
//#Preview {
//    ProgressBarView()
//}
