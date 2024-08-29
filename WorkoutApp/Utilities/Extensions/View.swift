//
//  View.swift
//  WorkoutPulse
//
//  Created by Leon Grimmeisen on 29.08.24.
//

import Foundation
import SwiftUI

extension View {
    func navigationTitle(_ titleKey: LocalizedStringResource) -> some View {
        self.navigationTitle(String(localized: titleKey))
    }
}
