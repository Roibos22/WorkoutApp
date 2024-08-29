//
//  LocalizedStringResource.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 29.08.24.
//

import Foundation

extension LocalizedStringResource: Comparable {
    public static func < (lhs: LocalizedStringResource, rhs: LocalizedStringResource) -> Bool {
        let lhsString = String(localized: lhs)
        let rhsString = String(localized: rhs)
        return lhsString.localizedCompare(rhsString) == .orderedAscending
    }
}
