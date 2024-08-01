//
//  Activity.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 01.08.24.
//

import Foundation

struct Activity: Hashable, Identifiable {
    let id: UUID
    var title: String
    var type: ActivityType
    var duration: TimeInterval
    var timeLeft: TimeInterval
    var startingTime: TimeInterval
    var cycleNo: Int
    var activityNo: Int
    
    init(id: UUID = UUID(), title: String, type: ActivityType, duration: TimeInterval, timeLeft: TimeInterval, startingTime: TimeInterval, cycleNo: Int, activityNo: Int) {
        self.id = id
        self.title = title
        self.type = type
        self.duration = duration
        self.timeLeft = timeLeft
        self.startingTime = startingTime
        self.cycleNo = cycleNo
        self.activityNo = activityNo
    }
}

enum ActivityType: String, Identifiable, Codable, CaseIterable {
    case countdown, exercise, rest, done
    
    var name: String { rawValue.capitalized }
    var id: String { rawValue }
}
