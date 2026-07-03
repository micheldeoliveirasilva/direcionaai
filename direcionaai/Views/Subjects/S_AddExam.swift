//
//  S_AddExam.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
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
                
                ToolbarItem(placement: .cancellationAction) {
                    
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    
                    Button("Salvar") {
                        
                        let newExam = Exams(
                            assesmentsDate: examDate,
                            assessments: examGrade,
                            assesmentsName: examName
                        )
                        
                        subject.exams.append(newExam)
                        
                        dismiss()
                    }
                    .disabled(
                        examName
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                            .isEmpty
                    )
                }
            }
        }
    }
}
//#Preview {
//    S_AddExam()
//}
