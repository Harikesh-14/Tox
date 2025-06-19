//
//  Item.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 18/06/25.
//

import Foundation
import SwiftData

@Model
final class Task {
    var title: String
    var desc: String
    var dateAndTime: Date
    var isCompleted: Bool
    var isImportant: Bool
    
    init(title: String = "", desc: String = "", dateAndTime: Date = .now, isCompleted: Bool = false, isImportant: Bool = false) {
        self.title = title
        self.desc = desc
        self.dateAndTime = dateAndTime
        self.isCompleted = isCompleted
        self.isImportant = isImportant
    }
}
