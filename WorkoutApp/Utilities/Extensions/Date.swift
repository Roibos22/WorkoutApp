//
//  Date.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 09.08.24.
//

import Foundation

extension Date {
    var removeTime: Date {
        Calendar.current.startOfDay(for: self)
    }
}
