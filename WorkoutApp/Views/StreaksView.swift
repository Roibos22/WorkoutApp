//
//  StreaksView.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 13.08.24.
//

import SwiftUI

struct StreaksView: View {
    @ObservedObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.red)
                Text("\(appState.getCurrentStreak())")
            }
            .foregroundColor(.primary)
            .font(.title2)
            .bold()
        }
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
                        Text("Streaks")
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

#Preview {
    StreaksView(appState: AppState())
}
