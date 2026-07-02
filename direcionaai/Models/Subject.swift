//
//  Disciplina.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//
// criar uma struct e fazer um array dessa struct para avaliacao
// Dados das disciplinas
import Foundation
import SwiftUI
import SwiftData

struct Exams: Codable {
    var assesmentsDate: Date
    var assessments: Double
    var assesmentsName: String
}

enum SubjectColor: String, Codable, CaseIterable, Identifiable {
    case verde
    case azul
    case vermelho
    case amarelo
    case laranja
    case roxo
    case rosa
    case preto
    case marrom
    
    var id: Self {
        self
    }
    
    var color: Color {
        switch self {
        case .verde:
            return .green
        case .azul:
            return .blue
        case .vermelho:
            return .red
        case .amarelo:
            return .yellow
        case .laranja:
            return .orange
        case .roxo:
            return .purple
        case .rosa:
            return .pink
        case .preto:
            return .black
        case .marrom:
            return .brown
        }
    }
}

enum weekDay: String, Codable, CaseIterable, Identifiable {
    
    case dom, seg, ter, qua, qui, sex, sab
    
    var id: String { self.rawValue }
    
    var nameDay: String {
        
        switch self{
        case .dom: return "Domingo"
        case .seg: return "Segunda"
        case .ter: return "Terça"
        case .qua: return "Quarta"
        case .qui: return "Quinta"
        case .sex: return "Sexta"
        case .sab: return "Sábado"
        }
    }
    
}

@Model
class subjectDay {
    var day: weekDay
    var startTime: Date
    var endTime: Date
    
    init(day: weekDay, startTime: Date, endTime: Date) {
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
    }
}

@Model
final class Subject {
    
    var exams: [Exams]
    
    var subjectName: String
    var professorName: String
    var professorEmail: String
    var subjectDescription: String
    
    @Relationship(deleteRule: .cascade)
    var subjectSchedule: [subjectDay]
    var absences: Int
    var subjectColor: SubjectColor
    
    init(
        exams: [Exams],
        subjectName: String,
        professorName: String,
        professorEmail: String,
        subjectDescription: String,
        subjectSchedule: [subjectDay],
        absences: Int = 0,
        subjectColor: SubjectColor
    ) {
        self.exams = exams
        self.subjectName = subjectName
        self.professorName = professorName
        self.professorEmail = professorEmail
        self.subjectDescription = subjectDescription
        self.subjectSchedule = subjectSchedule
        self.absences = absences
        self.subjectColor = subjectColor
    }
}

@Model
class ExtracurricularActivity {
    
    var name: String
    var day: String
    var startTime: Date
    var endTime: Date
    var activityDescription: String
    
    init(
        name: String,
        day: String,
        startTime: Date,
        endTime: Date,
        activityDescription: String
    ) {
        self.name = name
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.activityDescription = activityDescription
    }
}
