//
//  ProgressCircleView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 05.08.24.
//

import SwiftUI

struct ProgressCircleView: View {
    @ObservedObject var viewModel: WorkoutActiveViewModel

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: viewModel.circleProgress)
                .stroke(
                    viewModel.isRestActivity ? Color.blue : Color.black,
                    style: StrokeStyle(lineWidth: 30, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: viewModel.circleProgress)

            VStack {
                Text(viewModel.currentActivityTimeLeft.asDigitalMinutes())
                    .font(.system(size: 60, weight: .bold))
                Text(viewModel.workoutTimeLeft.asDigitalMinutes())
                    .font(.title2)
            }
            .foregroundColor(viewModel.isRestActivity ? .blue : .black)
        }
        .frame(height: 300)
    }
}

//#Preview {
//    ProgressCircleView()
//}
