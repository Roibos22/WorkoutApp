//
//  Double.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 04.10.23.
//

import Foundation

extension Double {
    
    private var secondsFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .none
        
        return formatter
    }
    
    // 0s
    func asSeconds() -> String {
        let number = NSNumber(value: self)
        let formattedNumber = (secondsFormatter.string(from: number) ?? "0") + "s"
        return formattedNumber
    }
    
    // 0 seconds
    func asSecondsWritten() -> String {
        let number = NSNumber(value: self)
        let formattedNumber = (secondsFormatter.string(from: number) ?? "0") + " seconds"
        return formattedNumber
    }
    
    // 0m 0s
    func asMinutes() -> String {
        let number = NSNumber(value: self)
        let minuteValue = Int(truncating: number) / 60
        let secondsValue = Int(truncating: number) % 60
        let formattedNumber = "\(minuteValue)" + "m " + "\(secondsValue)" + "s"
        return formattedNumber
    }
    
    // 00:00
    func asDigitalMinutes() -> String {
        let totalSeconds = self
        
        var minutes: Int
        var seconds: Int
        
        if totalSeconds > 1 {
            minutes = Int(floor(totalSeconds / 60))
            seconds = Int(ceil(totalSeconds.truncatingRemainder(dividingBy: 60)))
            
            // Adjust for the case where seconds round up to 60
            if seconds == 60 {
                minutes += 1
                seconds = 0
            }
        } else if totalSeconds > 0 {
            minutes = 0
            seconds = 1
        } else {
            minutes = 0
            seconds = 0
        }
        
        let formattedMinuteString = String(format: "%02d", minutes)
        let formattedSecondsString = String(format: "%02d", seconds)
        
        return "\(formattedMinuteString):\(formattedSecondsString)"
    }
}
