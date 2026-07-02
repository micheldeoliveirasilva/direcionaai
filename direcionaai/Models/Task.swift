//
//  Task.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// Dados das atividades
import Foundation
import SwiftData
import SwiftUI

enum Priority: String, Codable, CaseIterable {
    case low = "Baixa"
    case medium = "Média"
    case high = "Alta"
    
    var color: Color {
        switch self {
        case .high:
            return .red
        case .medium:
            return .yellow
        case .low:
            return .green
        }
    }
}

enum Status: String, Codable, CaseIterable {
    case toDo = "Para fazer"
    case inProgress = "Em andamento"
    case done = "Concluída"
    case archived = "Arquivada"
}

@Model
class UserTask {
    
    var taskName: String
    var priority: Priority
    var subject: Subject
    var dateLimit: Date
    var notes: String
    var status: Status
    
    init(
        taskName: String,
        priority: Priority,
        subject: Subject,
        dateLimit: Date,
        notes: String,
        status: Status,
    ) {
        self.taskName = taskName
        self.priority = priority
        self.subject = subject
        self.dateLimit = dateLimit
        self.notes = notes
        self.status = status
    }
}

