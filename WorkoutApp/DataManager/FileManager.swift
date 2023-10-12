//
//  FileManager.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 12.10.23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
