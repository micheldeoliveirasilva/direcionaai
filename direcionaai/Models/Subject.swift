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

enum weekDay: String, Codable, CaseIterable {
    
    case dom = "Domingo"
    case seg = "Segunda"
    case ter = "Terça"
    case qua = "Quarta"
    case qui = "Quinta"
    case sex = "Sexta"
    case sab = "Sábado"
    
}

enum hourAbsences: String, Codable, CaseIterable {
    
    case time1 = "30h"
    case time2 = "45h"
    case time3 = "60h"
    case time4 = "75h"
    case time5 = "90h"
    case time6 = "120h"
    
    var totalAbsenses: Int {
        switch self {
        case .time1:
            return 8
        case .time2:
            return 13
        case .time3:
            return 18
        case .time4:
            return 22
        case .time5:
            return 26
        case .time6:
            return 36
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
    var absencesTime: hourAbsences
    var subjectColor: SubjectColor
    
    init(
        exams: [Exams],
        subjectName: String,
        professorName: String,
        professorEmail: String,
        subjectDescription: String,
        subjectSchedule: [subjectDay],
        absences: Int = 0,
        absencesTime: hourAbsences,
        subjectColor: SubjectColor,
    ) {
        self.exams = exams
        self.subjectName = subjectName
        self.professorName = professorName
        self.professorEmail = professorEmail
        self.subjectDescription = subjectDescription
        self.subjectSchedule = subjectSchedule
        self.absences = absences
        self.absencesTime = absencesTime
        self.subjectColor = subjectColor
    }
}
