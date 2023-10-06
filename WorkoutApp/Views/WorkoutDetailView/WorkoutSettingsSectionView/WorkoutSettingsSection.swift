//
//  WorkoutSettingsSection.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 06.10.23.
//

import SwiftUI

enum WorkoutSettingsCardFormats {
    case asMinutes
    case asNumber
}

struct WorkoutSettingsCard: View {
    
    let title: String
    let icon: String
    let value: Double
    let format: WorkoutSettingsCardFormats
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
            //.position(x: 0, y: 0)
                .offset(x: 15, y: -43)
                .foregroundColor(.gray)
                .bold()
                .font(.subheadline)
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 2)
                .frame(height: 60)
                .foregroundColor(.white)
            HStack {
                Image(systemName: icon)
                Spacer()
                switch format {
                case .asMinutes:
                    Text(value.asDigitalMinutes())
                case .asNumber:
                    Text("\(value.formatted())")
                }
            }
            .padding()
            .font(.title)
            .bold()
        }
        .padding(.vertical, 10)
    }
}

struct WorkoutSettingsSection: View {
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "dumbbell.fill")
                Text("Workout Settings")
                Spacer()
            }
            .font(.title2)
            .bold()
            VStack {
                HStack {
                    WorkoutSettingsCard(title: "Exercise Duration", icon: "stopwatch", value: 20,format: .asMinutes)
                    WorkoutSettingsCard(title: "Exercise Rest", icon: "hourglass.circle", value: 20,format: .asMinutes)
                }
                HStack {
                    WorkoutSettingsCard(title: "Cycles", icon: "repeat", value: 2,format: .asNumber)
                    WorkoutSettingsCard(title: "Cycle Rest", icon: "hourglass.circle", value: 20,format: .asMinutes)
                }
            }
        }
    }
}
struct WorkoutSettingsSection_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSettingsSection()
    }
}
