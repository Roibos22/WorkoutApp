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
        HStack(spacing: 40) {
            controlButton(systemName: "stop.circle.fill") {
                showEndAlert = true
            }

            controlButton(systemName: viewModel.isPaused ? "play.circle.fill" : "pause.circle.fill") {
                viewModel.togglePause()
            }

            controlButton(systemName: "forward.fill") {
                viewModel.skipActivity()
            }
        }
        .font(.system(size: 40))
        .foregroundColor(viewModel.isRestActivity ? .blue : .black)
    }

    private func controlButton(systemName: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
        }
    }
}

//#Preview {
//    ControlButtonsView()
//}
