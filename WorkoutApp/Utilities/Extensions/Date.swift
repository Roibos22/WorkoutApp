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
    
    func formatDDMMMYYYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d. MMM yyyy"
        // Ensure the month abbreviation is always in English
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
}
