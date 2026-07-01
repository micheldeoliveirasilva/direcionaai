//
//  Task.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// Dados das atividades
import Foundation
import SwiftData

enum Priority: String, Codable, CaseIterable {
    case low = "Baixa"
    case medium = "Média"
    case high = "Alta"
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
    var progress: String
    var status: Status
    var subjectColor: SubjectColor
    
    init(
        taskName: String,
        priority: Priority,
        subject: Subject,
        dateLimit: Date,
        notes: String,
        progress: String,
        status: Status,
        subjectColor: SubjectColor
    ) {
        self.taskName = taskName
        self.priority = priority
        self.subject = subject
        self.dateLimit = dateLimit
        self.notes = notes
        self.progress = progress
        self.status = status
        self.subjectColor = subjectColor

    }
}
