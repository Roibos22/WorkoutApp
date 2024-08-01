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
        let number = NSNumber(value: self)
        let minuteValue = Int(truncating: number) / 60
        let secondsValue = Int(truncating: number) % 60
        let formattedMinuteString: String = (minuteValue >= 10 ? "\(minuteValue)" : "0" + "\(minuteValue)")
        let formattedSecondsString: String = (secondsValue >= 10 ? "\(secondsValue)" : "0" + "\(secondsValue)")
        let formattedNumber = formattedMinuteString + ":" + formattedSecondsString
        return formattedNumber
    }
}
