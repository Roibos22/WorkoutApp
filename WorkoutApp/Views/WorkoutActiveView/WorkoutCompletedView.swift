//
//  WorkoutCompletedView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 19.12.23.
//

import SwiftUI
import ConfettiSwiftUI

struct WorkoutCompletedView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: ViewModel
    
    @State var workout: Workout
    @State var workoutTimeline: [Activity]
    
    @State private var counter = 0
    
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State private var colorSwitchedCounter: Int = 0
    
    var totalTime: Double {
        workoutTimeline.lazy.reduce(0) {
            $0 + $1.duration
        }
    }
    
    var totalExercises: Int { workout.exercises.count * workout.cycles }

    // Colors
    @State private var oppositeColor: Bool = true
    var mainColor : Color = .blue
    var accentColor : Color = .black
    
//    var accentColor2 : Color {
//        accentColor == vm.selectedColorTheme.lightAccentColor ? vm.selectedColorTheme.darkAccentColor : vm.selectedColorTheme.lightAccentColor
//    }
    
    //MARK: BODY
    
    var body: some View {
        
        VStack {
            Spacer()

            VStack {
                Text("Congratulations!")
                    .font(.system(size: 35))
                    .padding(5)
                Text("You just finished another Tabata")
                    .font(.callout)
            }
            
            Spacer()
            
            VStack(spacing: 10) {
                Text(workout.title)
                    .font(.title)
                HStack {
                    Image(systemName: "clock.fill")
                    Text("Total Duration:")
                    Text("\(totalTime.asMinutes())")
                }
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Exercises completed:")
                    Text("\(totalExercises)")
                }
            }
            .font(.title3)
            
            Spacer()

            Button {
                counter += 1
            } label: {
                Text("🎉")
                    .font(.system(size: 70))
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: .infinity)
                        .foregroundColor(oppositeColor ? mainColor : .black)
                    Text("End Tabata")
                        .foregroundColor(oppositeColor ? accentColor : .white)
                        .bold()
                        .font(.title2)
                }
                .frame(width: 200, height: 75)
            }
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(oppositeColor ? accentColor : mainColor)
        .foregroundColor(oppositeColor ? mainColor : accentColor)
        .bold()
        .confettiCannon(
            counter: $counter,
            num: 100,
            openingAngle: Angle.degrees(30),
            closingAngle: Angle.degrees(150)
        )
        .onAppear {
            
            // trigger confetti
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                if vm.soundsEnabled {
//                    SoundManager.instance.playSound(sound: .jubilant)
//                }
                self.counter += 1
            }
            
        }
        .onReceive(timer) { time in
            if colorSwitchedCounter < 10 {
                colorSwitchedCounter += 1
                oppositeColor.toggle()
            } else {
                self.timer.upstream.connect().cancel()
                colorSwitchedCounter = 0
            }
        }
        
        
    }
}

struct WorkoutCompletedView_Previews: PreviewProvider {
    static let myEnvObject = ViewModel()
    static var previews: some View {
        WorkoutCompletedView(workout: Workout.sampleWorkouts[0], workoutTimeline: myEnvObject.getWorkoutTimeline(workout: Workout.sampleWorkouts[0]))
    }
}
