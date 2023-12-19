//
//  ProgressCircleView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 19.12.23.
//

import SwiftUI

struct ProgressCircleView: View {
    @EnvironmentObject var vmMain: ViewModelMain
    @EnvironmentObject var vm: WorkoutActiveViewViewModel

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: circleProgress)
                .stroke(
                    isRestActivity ? mainColor : accentColor,
                    style: StrokeStyle(
                        lineWidth: 30,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: circleProgress)
            
            ZStack {
                VStack {
                    Spacer()
                    //Text("skipped")
                    
                    ZStack {
                        if paused {
                            Text("paused")
                        } else {
                            Text(showSkipped ? "skipped" : "      ")

                                .opacity(showSkipped ? 1.0 : 0)
                        }
                    }
                    .frame(alignment: .center)
                    .font(.title)

                    Spacer()
                    Spacer()
                    HStack {
                        Image(systemName: "clock.fill")
                        Text((workoutTimeLeft + 1.0).asDigitalMinutes())
                            .font(.title)
                    }
                    Spacer()
                }
                Text("\((currentActivityTimeLeft + 1).asDigitalMinutes())")
                    .font(.system(size: 80))
            }
            .foregroundColor(isRestActivity ? mainColor : accentColor)
            .bold()
        }
    }
}

struct ProgressCircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView()
    }
}
