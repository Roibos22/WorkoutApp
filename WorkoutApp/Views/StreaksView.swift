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
    
    let achievements: [Achievement] = Achievement.streakAchievements
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack(spacing: 20) {
                    ZStack {
                        VStack {
                            HStack {
                                Image(systemName: "flame.fill")
                                Text("\(appState.getCurrentStreak())")
                                    .foregroundColor(.black)
                            }
                            .foregroundColor(.red)
                            .bold()
                            .font(.system(size: 40))
                            .padding()

                            Text("Current Streak")
                                .font(.callout)
                                .bold()
                            Text("12. Aug. '24")
                                .font(.callout)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    
                    ZStack {
                        VStack {
                            HStack {
                                Image(systemName: "flame.fill")
                                Text("\(appState.getCurrentStreak())")
                                    .foregroundColor(.black)
                            }
                            .foregroundColor(.orange)
                            .bold()
                            .font(.system(size: 40))
                            .padding()

                            Text("Longest Streak")
                                .font(.callout)
                                .bold()
                            Text("12. Aug. '24")
                                .font(.callout)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                }
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
