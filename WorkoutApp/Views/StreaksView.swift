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
            ThreeColumnGrid()
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

struct Achievement: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var color: Color
    
    static let achievements: [Achievement] = [
        Achievement(title: "Newbie", image: "trophy.fill", color: .blue),
        Achievement(title: "Amatuer", image: "trophy.fill", color: .red),
        Achievement(title: "Pro", image: "trophy.fill", color: .gray),
        Achievement(title: "Pro", image: "question.mark", color: .gray),
        Achievement(title: "Legend", image: "trophy.fill", color: .yellow)
    ]
}

struct ThreeColumnGrid: View {
    let items = Achievement.achievements
    let columns = [
        GridItem(.flexible()),
       // GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items) { item in
                    ZStack {
                        VStack {
                            Image(systemName: item.image)
                                .font(.system(size: 60))
                                .bold()
                                .foregroundColor(item.color)
                            Text(item.title)
                                .frame(maxWidth: .infinity)
                                .font(.title3)
                                .bold()
                            Text("Complete 1st workout")
                                .font(.callout)
                        }
                    }
                    .frame(height: 160)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    StreaksView(appState: AppState())
}
