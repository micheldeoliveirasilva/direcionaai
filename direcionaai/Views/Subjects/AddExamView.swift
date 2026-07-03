//
//  AddExamView.swift
//  direcionaai
//
//  Created by Débora Lemos on 03/07/26.
//
//

// Sheet de adicionar avaliação na disciplina

import SwiftUI
import SwiftData

struct AddExamView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var subject: Subject
    
    @State private var examName = ""
    @State private var examDate = Date()
    @State private var examGrade = 0.0
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Informações") {
                    
                    TextField(
                        "Nome da avaliação",
                        text: $examName
                    )
                    
                    DatePicker(
                        "Data",
                        selection: $examDate,
                        displayedComponents: .date
                    )
                    
                    TextField(
                        "Nota",
                        value: $examGrade,
                        format: .number
                    )
                    .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Nova avaliação")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                        let newExam = Exams(
                            assesmentsDate: examDate,
                            assessments: examGrade,
                            assesmentsName: examName
                        )
                        
                        subject.exams.append(newExam)
                        dismiss()
                        
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

#Preview("Nova avaliação") {
    
    AddExamView(
        subject: Subject(
            exams: [],
            subjectName: "Fonética e fonologia",
            professorName: "Maria Silva",
            professorEmail: "maria@ufpe.br",
            subjectDescription: "Estudo dos sons da fala.",
            subjectSchedule: [
                SubjectDay(
                    day: .seg,
                    startTime: .now,
                    endTime: .now
                )
            ],
            absences: 0,
            absencesTime: .time3,
            subjectColor: .azul
        )
    )
    .modelContainer(
        for: Subject.self,
        inMemory: true
    )
}
