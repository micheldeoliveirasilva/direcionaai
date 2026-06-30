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

@Model
class Subject {

    var exams: [Exams]
    var subjectName: String
    var professorName: String
    var professorEmail: String
    var subjectDescription: String

    var subjectDay: String
    var startTime: Date
    var endTime: Date
    var absences: Int
    var subjectColor: Color

    init(
        exams: [Exams],
        subjectName: String,
        professorName: String,
        professorEmail: String,
        subjectDescription: String,
        subjectDay: String,
        startTime: Date,
        endTime: Date,
        absences: Int,
        color: Color
    ) {
        self.exams = exams
        self.subjectName = subjectName
        self.professorName = professorName
        self.professorEmail = professorEmail
        self.subjectDescription = subjectDescription
        self.subjectDay = subjectDay
        self.startTime = startTime
        self.endTime = endTime
        self.absences = absences
        self.subjectColor = color
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
