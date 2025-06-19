//
//  TaskFilter.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 18/06/25.
//

import Foundation

enum TaskFilter: Int, CaseIterable {
    case all
    case pending
    case completed
    
    var title: String {
        switch self {
        case .all: return "All"
        case .pending: return "Pending"
        case .completed: return "Completed"
        }
    }
}
