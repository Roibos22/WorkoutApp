//
//  WorkoutModel.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.10.23.
//

import Foundation

struct Workout: Identifiable {
    let id = UUID()
    var title: String
    var cycles: Int
    var duration: Double
    var exercises: Int
}

extension Workout {
    static var sampleWorkouts: [Workout] = [
        Workout(title: "Tabata", cycles: 2, duration: 1060, exercises: 5),
        Workout(title: "Kegel", cycles: 3, duration: 500, exercises: 3),
        Workout(title: "Workout", cycles: 17, duration: 3000, exercises: 3),
        Workout(title: "Body Core", cycles: 4, duration: 2500, exercises: 12)
    ]
}
