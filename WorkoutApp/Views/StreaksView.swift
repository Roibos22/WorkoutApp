//
//  StreaksView.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 13.08.24.
//

import SwiftUI


struct Achievement: Identifiable {
    var id = UUID()
    var title: String
    var caption: String
    var icon: String
    var iconColor: Color
    var achieved: Bool
    
    static let streakAchievements = [
        Achievement(title: "Newbie", caption: "Work out for 1 day", icon: "figure.walk", iconColor: .blue, achieved: true),
        Achievement(title: "Starter", caption: "3-day workout streak", icon: "stopwatch.fill", iconColor: .cyan, achieved: false),
        Achievement(title: "Weekly", caption: "7-day workout streak", icon: "calendar", iconColor: .teal, achieved: true),
        Achievement(title: "Fortnight", caption: "14-day workout streak", icon: "flame.fill", iconColor: .green, achieved: true),
        Achievement(title: "Monthly", caption: "30-day workout streak", icon: "moon.stars.fill", iconColor: .yellow, achieved: true),
        Achievement(title: "Champion", caption: "90-day workout streak", icon: "trophy.fill", iconColor: .orange, achieved: true)
    ]

    static let completionAchievements = [
        Achievement(title: "Newbie", caption: "Complete 1 workout", icon: "leaf.fill", iconColor: .blue, achieved: true),
        Achievement(title: "Starter", caption: "Complete 5 workouts", icon: "checkmark.circle.fill", iconColor: .cyan, achieved: true),
        Achievement(title: "Consistent", caption: "Complete 15 workouts", icon: "figure.walk", iconColor: .teal, achieved: true),
        Achievement(title: "Dedicated", caption: "Complete 30 workouts", icon: "dumbbell.fill", iconColor: .green, achieved: true),
        Achievement(title: "Warrior", caption: "Complete 50 workouts", icon: "shield.fill", iconColor: .yellow, achieved: true),
        Achievement(title: "Champion", caption: "Complete 100 workouts", icon: "trophy.fill", iconColor: .orange, achieved: true)
    ]

    static let durationAchievements = [
        Achievement(title: "Tester", caption: "1 hour total workout time", icon: "clock.fill", iconColor: .blue, achieved: true),
        Achievement(title: "Beginner", caption: "5 hours total workout time", icon: "hourglass", iconColor: .cyan, achieved: true),
        Achievement(title: "Regular", caption: "10 hours total workout time", icon: "hourglass.bottomhalf.filled", iconColor: .teal, achieved: true),
        Achievement(title: "Committed", caption: "24 hours total workout time", icon: "figure.walk.", iconColor: .green, achieved: true),
        Achievement(title: "Devoted", caption: "48 hours total workout time", icon: "figure.run", iconColor: .yellow, achieved: true),
        Achievement(title: "Expert", caption: "100 hours total workout time", icon: "flame.fill", iconColor: .orange, achieved: true)
    ]

    static let miscAchievements = [
        Achievement(title: "Curious", caption: "Try 3 different workouts", icon: "eye.fill", iconColor: .blue, achieved: true),
        Achievement(title: "Explorer", caption: "Try 5 different workouts", icon: "map.fill", iconColor: .cyan, achieved: true),
        Achievement(title: "Adventurer", caption: "Try 10 different workouts", icon: "globe", iconColor: .teal, achieved: true),
        Achievement(title: "Creator", caption: "Created first custom workout", icon: "pencil", iconColor: .green, achieved: true),
        Achievement(title: "Scheduler", caption: "Saved a template workout", icon: "calendar", iconColor: .yellow, achieved: true),
        Achievement(title: "Early Bird", caption: "Completed a workout before 6 AM", icon: "sunrise.fill", iconColor: .orange, achieved: true)
    ]
}


struct StreaksView: View {
    @ObservedObject var appState: AppState
    @Environment(\.dismiss) private var dismiss
    
    let achievements: [Achievement] = Achievement.streakAchievements
    
    var body: some View {
        ScrollView {
            VStack {
                
                ZStack {
                    VStack {
                        HStack {
                            Image(systemName: "flame.fill")
                            Text("\(appState.getCurrentStreak())")
                                .foregroundColor(.black)
                        }
                        .foregroundColor(.red)
                        .bold()
                        .font(.system(size: 35))
                        .padding()

                        Text("Current Streak")
                            .font(.callout)
                            .bold()
                    }
                }
                .frame(width: 160, height: 160)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .padding()

//                HStack {
//                    Text("Awards")
//                        .font(.title)
//                        .bold()
//                    Spacer()
//                }
                
                achievementsScrollView(title: "Streaks", achievements: Achievement.streakAchievements)
                achievementsScrollView(title: "Completions", achievements: Achievement.completionAchievements)
                achievementsScrollView(title: "More", achievements: Achievement.durationAchievements)
                achievementsScrollView(title: "More", achievements: Achievement.miscAchievements)


                
            }
        }
        .scrollIndicators(.hidden)
        //.padding(.horizontal, 20)
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
                        Text("Achievements")
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

struct achievementsScrollView: View {
    let title: String
    let achievements: [Achievement]
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.horizontal, 20)
            Spacer()
        }
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                ForEach(achievements) { achievement in
                    AchievementView(achievement: achievement)
                        .frame(width: 150, height: 150)
                        .background(achievement.achieved ? Color.gray.opacity(0.15) : Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
    }
}

struct AchievementView: View {
    let achievement: Achievement
    @State private var showingInfo = false

    var body: some View {
        ZStack {
            VStack {

                
                ZStack {
                    VStack {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .opacity(achievement.achieved ? 1 : 0)
                                .bold()
                            Spacer()
                            Button {
                                withAnimation { showingInfo.toggle() }
                            } label: {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.blue)
                                    .bold()
                            }
                            //.padding()
                        }
                        .padding(10)
                        Spacer()
                    }
                    
                    Image(systemName: achievement.achieved ? achievement.icon : "questionmark.circle.fill")
                        .font(.system(size: 70))
                        .foregroundColor(achievement.achieved ? achievement.iconColor : .gray)
                        .frame(width: 150, height: 60)
                        .padding(.top, 15)
                   
                }
                
                Text(achievement.title)
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                

                
            }
            .overlay(
                Group {
                    if showingInfo {
                        infoPopup
                    }
                }
            )
        }
    }
    
    private var infoPopup: some View {
        VStack {
            Button {
                withAnimation {
                    showingInfo = false
                }
            } label: {
                Text(achievement.caption)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.top, 5)
        }
        .transition(.scale.combined(with: .opacity))
        .zIndex(1)
    }
}


#Preview {
    NavigationView {
        StreaksView(appState: AppState())
    }
}
