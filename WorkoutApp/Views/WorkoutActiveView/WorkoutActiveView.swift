//
//  WorkoutActiveView.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 11.10.23.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct WorkoutActiveView: View {
    
    //MARK: VARIABLES
    // Environment
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: ViewModel
    
    // Passed in variables
    @State var workout: Workout
    @State var workoutTimeline: [Activity]
    
    // View State
    @State private var isRunning: Bool = true
    @State private var tabataFinished: Bool = false
    
    // Circle & Bar progress
    @State private var circleProgress: Double = 0.0
    @State private var barProgress: Double = 0.0
    
    // Time
    
    // make this a passed in value later
    @State var workoutTimeLeft: Double
    @State var currentActivityTimeLeft: Double
    
//    var totalWorkoutTime: Double {
//        workoutTimeline.lazy.reduce(0) {
//            $0 + $1.duration
//        }
//    }
    @State private var workoutDurationDone: Double = 0.0
    @State private var currentActivityDurationDone: Double = 0.0

    var currentActivityDuration: Double { currentActivity.duration }
    
    
    // Timer
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    // Activities
    var currentActivity: Activity { workoutTimeline[activityCount] }

    @State private var activityCount: Int = 0
    
    var isRestActivity : Bool {
        currentActivity.title == "Rest"
    }
    
    // Buttons
    @State private var paused: Bool = false

    //Colors
    var mainColor : Color = .blue
    var accentColor : Color = .black

    // Alerts
    @State private var showEndAlert = false
    
    // Skipping
    @State private var skippedTimer: Double = 1.0
    @State private var showSkipped: Bool = false
    
    // Sounds
    
    @State private var countdownPlayed: Bool = false

    //MARK: BODY
    
    var body: some View {
        
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
                        Spacer()
                        runningActivity
                        nextActivity
                            .padding(.top)
                        Text("\(activityCount)")
                        Text("\(workoutTimeline.count)")
                        Spacer()
                        progressCircle
                            .frame(width: UIScreen.screenWidth * 0.8, height: UIScreen.screenWidth * 0.8)
                        Spacer()
                        progressBar
                            .frame(width: UIScreen.screenWidth * 0.8)
                        Spacer()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isRestActivity ? accentColor : mainColor)
        .alert("End Tabata", isPresented: $showEndAlert) {
            Button("End Tabata") {
                dismiss()
            }
            Button("Cancel", role: .cancel, action: {})
        } message:  {
            Text("Are you sure you want to end your workout?")
        }
        
        //MARK: RECEIVE TIMER
        .onReceive(timer) { time in
        
            if !tabataFinished {
                print ("\(currentActivityTimeLeft)")
                if currentActivityTimeLeft < 0 {
                    // check if it was last activity
                    if activityCount == workoutTimeline.count - 2 {
                        // if yes end
                        isRunning = false
                        tabataFinished = true
                        print ("\(tabataFinished)")
                        self.timer.upstream.connect().cancel()
                    } else {
                        // if no set up next one
                        activityCount += 1
                        print(activityCount)
                        print(workoutTimeline.count)
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
                        //barProgress = (totalWorkoutTime - workoutTimeLeft) / (totalWorkoutTime)
                        barProgress = (workout.duration - workoutTimeLeft) / workout.duration
                    }
                }
                                
                // play sounds
//                if vm.soundsEnabled {
//                    if currentActivityTimeLeft < 3 && countdownPlayed == false {
//                        DispatchQueue.main.async {
//                            //SoundManager.instance.playSound(sound: .countdown)
//                        }
//                        countdownPlayed = true
//                    }
//                }
                
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
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
//        .onAppear{
//
//            DispatchQueue.main.async {
//                SoundManager.instance.prepare()
//            }
//
//        }

    }
}

//MARK: COMPONENTS

extension WorkoutActiveView {
    
    //MARK: ACTIVITY DISPLAY
    
    private var nextActivity: some View {
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
    
    private var runningActivity: some View {
        
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
            .frame(width: UIScreen.screenWidth * 0.8)
            .frame(minHeight: 70)
            .fixedSize(horizontal: false, vertical: true)
    }

    //MARK: CIRCLE DISPLAY

    private var progressCircle: some View {
        ZStack {
            Circle()
                .trim(from: 0, to:circleProgress)
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
    
    //MARK: PROGRESS BAR
    
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
                // if yes end
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
//            if vm.soundsEnabled {
//                DispatchQueue.main.async {
//                    //SoundManager.instance.player?.pause()
//                }
//            }
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
            //if vm.soundsEnabled {
            //    DispatchQueue.main.async {
            //        //SoundManager.instance.player?.play()
            //    }
            //}
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
    }
    //static var previews: some View {
    //    NavigationView {
    //        WorkoutView(tabata: dev.tabataOne, tabataTimeline: dev.tabataOneTimeline, tabataTimeLeft: dev.tabataOneDuration, currentActivityTimeLeft: dev.tabataOneFirstAvtivityDuration)
     //   }
     //   .navigationTitle("Tabata")
     //   .environmentObject(myEnvObject)
    //}
}
