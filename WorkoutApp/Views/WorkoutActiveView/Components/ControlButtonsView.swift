//
//  ControlButtonsView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 05.08.24.
//

import SwiftUI

struct ControlButtonsView: View {
    @ObservedObject var viewModel: WorkoutActiveViewModel
    @Binding var showEndAlert: Bool

    var body: some View {
        ZStack {
            HStack {
                if viewModel.isPaused {
                    Button("", systemImage: "stop.circle.fill") {
                        showEndAlert = true
                    }
                    Button("", systemImage: "play.circle.fill") {
                        viewModel.togglePause()
                    }
                } else {
                    Button("", systemImage: "chevron.right.circle.fill") {
                        viewModel.skipActivity()
                    }
                    Button("", systemImage: "pause.circle.fill") {
                        viewModel.togglePause()
                    }
                }
            }
            .font(.title)
            HStack {
                Image(systemName: "repeat")
                Text("\(viewModel.currentActivity.cycleNo)/\(viewModel.workout.cycles)")
                Spacer()
                Image(systemName: "dumbbell.fill")
                Text("\(viewModel.currentActivity.activityNo)/\(viewModel.workout.exercises.count)")
            }
        }
        .foregroundColor(viewModel.isRestActivity ? .blue : .black)
        .font(.title2)
        .bold()
    }

}

//#Preview {
//    ControlButtonsView()
//}
