//
//  ActivityDisplayView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 05.08.24.
//

import SwiftUI

struct ActivityDisplayView: View {
    @ObservedObject var viewModel: WorkoutActiveViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.currentActivity.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(viewModel.isRestActivity ? Color.blue : Color.black, lineWidth: 6)
                )
            
            if let nextActivity = viewModel.nextActivity {
                Text("Next: \(nextActivity.title)")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .foregroundColor(viewModel.isRestActivity ? .blue : .black)
    }
}


//
//#Preview {
//    ActivityDisplayView()
//}
