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
import UniformTypeIdentifiers



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

enum TaskSubject: Hashable {
    case subject(Subject)
    case activity(ExtracurricularActivity)
    
    var name: String {
            switch self {
            case .subject(let subject):
                return subject.subjectName
            case .activity(let activity):
                return activity.name
            }
        }
    
    var color: Color {
            switch self {
            case .subject(let subject):
                return subject.subjectColor.color
                
            case .activity(let activity):
                return activity.activityColor.color
            }
        }
}

@Model
class UserTask {
    
    var id: UUID
    var taskName: String
    var priority: Priority
    var dateLimit: Date
    var notes: String
    var status: Status
    
    var subject: Subject?
    var activity: ExtracurricularActivity?
    
    init(
        id: UUID,
        taskName: String,
        priority: Priority,
        subject: Subject? = nil,
        activity: ExtracurricularActivity? = nil,
        dateLimit: Date,
        notes: String,
        status: Status,
    ) {
        self.id = id
        self.taskName = taskName
        self.priority = priority
        self.subject = subject
        self.dateLimit = dateLimit
        self.notes = notes
        self.status = status
    }
}

