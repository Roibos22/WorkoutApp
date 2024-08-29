//
//  Exercise.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 01.08.24.
//

import Foundation

struct Exercise: Identifiable, Codable, Equatable {
    let id: UUID
    var title: LocalizedStringResource
    var duration: TimeInterval
    var rest: TimeInterval
    
    init(id: UUID = UUID(), title: LocalizedStringResource, duration: TimeInterval, rest: TimeInterval) {
        self.id = id
        self.title = title
        self.duration = duration
        self.rest = rest
    }
}
