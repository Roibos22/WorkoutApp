//
//  Cycle.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 01.08.24.
//

import Foundation

struct Cycle: Hashable, Identifiable {
    let id: UUID
    var title: String
    var duration: TimeInterval
    var startingTime: TimeInterval
    var activities: [Activity]
    var cycleNumber: Int
    
    init(id: UUID = UUID(), title: String, duration: TimeInterval, startingTime: TimeInterval, activities: [Activity], cycleNumber: Int) {
        self.id = id
        self.title = title
        self.duration = duration
        self.startingTime = startingTime
        self.activities = activities
        self.cycleNumber = cycleNumber
    }
}
