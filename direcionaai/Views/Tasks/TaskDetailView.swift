//
//  TaskDetailView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// INFORMAÇÕES DA VISUALIZAÇÃO DA TAREFA COMO O QUADRADO
import SwiftUI


struct TaskDetailView: View {
    
    let task: UserTask

    var body: some View {
                
        GroupBox {
            VStack(alignment: .leading) {
                
                                    
                Text(task.taskName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(2)
                
                HStack {
                    
                    Text(task.subject.subjectName)
                        .font(.footnote)
                        .fontWeight(.light)
                        .padding(5)
// add later subject.color
                        .background(.red.secondary)
                        .cornerRadius(6)
                    
                    Text(task.priority.rawValue)
                        .font(.footnote)
                        .fontWeight(.light)
                        .padding(5)
// add later task.priority.color
                        .background(.blue.secondary)
                        .cornerRadius(6)

                }
                
            }
            .frame(width: 150, height: 100, alignment: .leading)

        }
    }
    
}
#Preview {
    
    let subject = Subject(exams: [], subjectName: "Matemática", professorName: "", professorEmail: "", subjectDescription: "", subjectDay: "", startTime: .now, endTime: .now, absences: 0)
    
    let task = UserTask(taskName: "Fazer lista", priority: .high, subject: subject, dateLimit: .now, notes: "", progress: "", status: .done)
        
    TaskDetailView(task: task)
}
