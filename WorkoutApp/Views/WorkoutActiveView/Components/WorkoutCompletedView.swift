////
////  WorkoutCompletedView.swift
////  WorkoutApp
////
////  Created by Leon Grimmeisen on 19.12.23.
////
//
//import SwiftUI
//import ConfettiSwiftUI
//
//struct WorkoutCompletedView: View {
//    @Environment(\.dismiss) private var dismiss
//    @EnvironmentObject var vm: ViewModel
//    
//    @State var workout: Workout
//    @State var workoutTimeline: [Activity]
//    @State private var counter = 0
//    @State private var colorSwitchedCounter: Int = 0
//    @State private var oppositeColor: Bool = true
//
//    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
//    
//    var totalExercises: Int { workout.exercises.count * workout.cycles }
//    var mainColor : Color = .blue
//    var accentColor : Color = .black
//    
//    private let confettiCount = 100
//    private let confettiOpeningAngle = Angle.degrees(30)
//    private let confettiClosingAngle = Angle.degrees(150)
//    private let timerInterval = 0.2
//    
//    var totalTime: Double {
//        workoutTimeline.lazy.reduce(0) {
//            $0 + $1.duration
//        }
//    }
//
//    var body: some View {
//        VStack {
//            Spacer()
//            congratulationsMessage
//            Spacer()
//            workoutSummary
//            Spacer()
//            confettiButton
//            Spacer()
//            endWorkoutButton
//            Spacer()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(oppositeColor ? accentColor : mainColor)
//        .foregroundColor(oppositeColor ? mainColor : accentColor)
//        .bold()
//        .confettiCannon(
//            counter: $counter,
//            num: confettiCount,
//            openingAngle: confettiOpeningAngle,
//            closingAngle: confettiClosingAngle
//        )
//        .onAppear(perform: startConfetti)
//        .onReceive(timer, perform: switchColor)
//    }
//}
//
////MARK: COMPONENTS
//
//extension WorkoutCompletedView {
//    
//    private var congratulationsMessage: some View {
//        VStack {
//            Text("Congratulations!")
//                .font(.system(size: 35))
//                .padding(5)
//            Text("You just finished another Workout")
//                .font(.callout)
//        }
//    }
//
//    private var workoutSummary: some View {
//        VStack(spacing: 10) {
//            Text(workout.title)
//                .font(.title)
//            HStack {
//                Image(systemName: "clock.fill")
//                Text("Total Duration:")
//                Text("\(totalTime.asMinutes())")
//            }
//            HStack {
//                Image(systemName: "checkmark.circle.fill")
//                Text("Exercises completed:")
//                Text("\(totalExercises)")
//            }
//        }
//        .font(.title3)
//    }
//
//    private var confettiButton: some View {
//        Button {
//            counter += 1
//        } label: {
//            Text("🎉")
//                .font(.system(size: 70))
//        }
//    }
//
//    private var endWorkoutButton: some View {
//        Button {
//            dismiss()
//        } label: {
//            ZStack {
//                RoundedRectangle(cornerRadius: .infinity)
//                    .foregroundColor(oppositeColor ? mainColor : .black)
//                Text("End Workout")
//                    .foregroundColor(oppositeColor ? accentColor : .white)
//                    .bold()
//                    .font(.title2)
//            }
//            .frame(width: 200, height: 75)
//        }
//    }
//}
//
////MARK: FUNCTIONS
//
//extension WorkoutCompletedView {
//    
//    private func startConfetti() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            if vm.soundsEnabled {
//                SoundManager.instance.playSound(sound: .jubilant)
//            }
//            self.counter += 1
//        }
//    }
//
//    private func switchColor(_ time: Date) {
//        if colorSwitchedCounter < 10 {
//            colorSwitchedCounter += 1
//            oppositeColor.toggle()
//        } else {
//            self.timer.upstream.connect().cancel()
//            colorSwitchedCounter = 0
//        }
//    }
//
//}
//
//struct WorkoutCompletedView_Previews: PreviewProvider {
//    static let myEnvObject = ViewModel()
//    static var previews: some View {
//        WorkoutCompletedView(workout: Workout.sampleWorkouts[0], workoutTimeline: myEnvObject.getWorkoutTimeline(workout: Workout.sampleWorkouts[0]))
//            .environmentObject(myEnvObject)
//    }
//}
