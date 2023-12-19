//
//  WorkoutActiveView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

struct WorkoutActiveView: View {
    
    //MARK: VARIABLES
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: ViewModel
    
    @State var workout: Workout
    @State var workoutTimeline: [Activity]
    @State var workoutTimeLeft: Double
    @State var currentActivityTimeLeft: Double
        
    @State private var isRunning = true
    @State private var tabataFinished = false
    @State private var workoutDurationDone = 0.0
    @State private var currentActivityDurationDone = 0.0
    @State private var countdownPlayed = false
    @State private var showEndAlert = false
    @State private var skippedTimer = 1.0
    @State var showSkipped = false
    @State var circleProgress = 0.0
    @State var barProgress = 0.0
    @State var activityCount = 0
    @State var paused = false
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var currentActivity: Activity { workoutTimeline[activityCount] }
    var currentActivityDuration: Double { currentActivity.duration }
    var isRestActivity: Bool { currentActivity.title == "Rest" }
    var mainColor: Color { .blue }
    var accentColor: Color { .black }
    
    var body: some View {
        
        //MARK: BODY
        VStack {
            if tabataFinished {
                WorkoutCompletedView(workout: workout, workoutTimeline: workoutTimeline)
                  .environmentObject(vm)
            } else {
                VStack {
                    if tabataFinished {
                        WorkoutCompletedView(workout: workout, workoutTimeline: workoutTimeline)
                          .environmentObject(vm)
                    } else {
                        workoutActiveContent
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isRestActivity ? accentColor : mainColor)
        .alert("End Tabata", isPresented: $showEndAlert) {
            Button("End Tabata") { dismiss() }
            Button("Cancel", role: .cancel, action: {})
        } message:  {
            Text("Are you sure you want to end your workout?")
        }
        .onReceive(timer, perform: updateTimer)
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
//        .onAppear{
//            DispatchQueue.main.async {
//                SoundManager.instance.prepare()
//            }
//        }
    }
}

//MARK: TIMER FUNCTION

private extension WorkoutActiveView {
    
    func updateTimer(_ time: Timer.TimerPublisher.Output) {
        
        if !tabataFinished && currentActivityTimeLeft < 0 {
            if activityCount == workoutTimeline.count - 2 {
                isRunning = false
                tabataFinished = true
                self.timer.upstream.connect().cancel()
            } else {
                activityCount += 1
                currentActivityTimeLeft = currentActivity.duration
                currentActivityDurationDone = 0.0
                countdownPlayed = false
            }
        }
        
        if isRunning {
            currentActivityTimeLeft -= 0.01
            workoutTimeLeft -= 0.01
            currentActivityDurationDone += 0.01
            withAnimation() {
                circleProgress = (currentActivityDurationDone) / (currentActivityDuration)
                barProgress = (workout.duration - workoutTimeLeft) / workout.duration
            }
        }
        
        if vm.soundsEnabled {
            if currentActivityTimeLeft < 3 && countdownPlayed == false {
                DispatchQueue.main.async {
                    SoundManager.instance.playSound(sound: .countdown)
                }
                countdownPlayed = true
            }
        }
        
        if showSkipped {
            skippedTimer -= 0.01
            if skippedTimer <= 0 {
                withAnimation(Animation.easeOut(duration: 1.0)) {
                    showSkipped = false
                }
            }
        }
        
    }
}

//MARK: WORKOUT ACTIVE CONTENT

private extension WorkoutActiveView {
    private var workoutActiveContent: some View {
        VStack {
            Spacer()
            activityDisplay
            Spacer()
            progressCircle
                .frame(height: UIScreen.screenWidth * 0.8)
            Spacer()
            progressBar
            Spacer()
        }
        .frame(width: UIScreen.screenWidth * 0.8)
    }
}


//MARK: ACTIVITY DISPLAY

extension WorkoutActiveView {
    
    var activityDisplay: some View {
        VStack {
            runningActivity
            nextActivity
                .padding(.top)
        }
    }
    
    var nextActivity: some View {
        VStack {
            HStack {
                Text("Next:")
                if activityCount - 1 < workoutTimeline.count {
                    Text("\(workoutTimeline[activityCount + 1].title)")
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .foregroundColor(isRestActivity ? mainColor : accentColor)
            .font(.title2)
            .frame(width: UIScreen.screenWidth * 0.8)
        }
    }
    
    var runningActivity: some View {
        Text("\(currentActivity.title)")
            .foregroundColor(isRestActivity ? mainColor : accentColor)
            .font(.title)
            .bold()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        isRestActivity ? mainColor : accentColor,
                        lineWidth: 15
                    )
                    .frame(width: UIScreen.screenWidth * 0.8)
                    .frame(minHeight: 75)
            )
            .frame(minHeight: 70)
            .fixedSize(horizontal: false, vertical: true)
    }
}

//MARK: PROGRESS CIRCLE
extension WorkoutActiveView {
    
    var progressCircle: some View {
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

//MARK: PROGRESS BAR

private extension WorkoutActiveView {
        
    private var progressBarHeader: some View {
        HStack(alignment: .bottom) {
            HStack {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                Text(" \(currentActivity.cycleNo)/\(workout.cycles)")
            }
            .bold()
            .multilineTextAlignment(.leading)
            .foregroundColor(isRestActivity ? mainColor : accentColor)
                
            Spacer()
            HStack {
                if paused {
                    endButton
                    continueButton
                } else {
                    skipButton
                    pauseButton
                }
            }
            Spacer()

            HStack {
                Image(systemName: "dumbbell.fill")
                Text(" \(currentActivity.activityNo)/\(workout.exercises.count)")
            }
            .bold()
            .multilineTextAlignment(.leading)
            .foregroundColor(isRestActivity ? mainColor : accentColor)

        }
        .font(.title3)
    }
    
    private var progressBar: some View {
        VStack {
            progressBarHeader
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                       isRestActivity ? mainColor : accentColor,
                       lineWidth: 10
                    )
                    .frame(width: UIScreen.screenWidth * 0.8, height: 30)
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(isRestActivity ? mainColor : accentColor)
                    .frame(width: (UIScreen.screenWidth * 0.8 * barProgress) * 0.97 , height: 30)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
            }
        }
    }
    
    //MARK: BUTTONS
    
    private var skipButton : some View {
        Button {
            if activityCount == workoutTimeline.count - 2 {
                isRunning = false
                tabataFinished = true
                self.timer.upstream.connect().cancel()
            }
            workoutTimeLeft -= currentActivityTimeLeft
            activityCount += 1
            currentActivityTimeLeft = currentActivity.duration
            currentActivityDurationDone = 0.0
            skippedTimer = 1.0
            showSkipped = true
        } label: {
            Image(systemName: "chevron.right.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor((isRestActivity ? mainColor : accentColor))
        }
    }
    
    private var pauseButton : some View {
        Button {
            paused.toggle()
            isRunning = false
            if vm.soundsEnabled {
                DispatchQueue.main.async {
                    SoundManager.instance.player?.pause()
                }
            }
        } label: {
            Image(systemName: "pause.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor((isRestActivity ? mainColor : accentColor))
        }
    }
    
    private var endButton : some View {
        Button {
            showEndAlert.toggle()
        } label: {
            Image(systemName: "stop.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
            .foregroundColor((isRestActivity ? mainColor : accentColor))
        }
    }
    
    private var continueButton : some View {
        Button {
            isRunning = true
            paused.toggle()
            if vm.soundsEnabled {
                DispatchQueue.main.async {
                    SoundManager.instance.player?.play()
                }
            }
        } label: {
            Image(systemName: "play.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
            .foregroundColor((isRestActivity ? mainColor : accentColor))
        }
    }
}


struct WorkoutActiveView_Previews: PreviewProvider {
    static let vm = ViewModel()
    static var previews: some View {
        WorkoutActiveView(workout: Workout.sampleWorkouts[0], workoutTimeline: vm.getWorkoutTimeline(workout: Workout.sampleWorkouts[0]), workoutTimeLeft: Workout.sampleWorkouts[0].duration, currentActivityTimeLeft: 10.0)
            .environmentObject(vm)
    }
}
