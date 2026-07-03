//
//  TaskDetailView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// INFORMAÇÕES DA VISUALIZAÇÃO DA TAREFA COMO O QUADRADO
import SwiftUI


struct TaskDetail: View {
    
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
                        .background(task.subject.subjectColor.color.opacity(0.6))
                        .cornerRadius(6)
                    
                    Text(task.priority.rawValue)
                        .font(.footnote)
                        .fontWeight(.light)
                        .padding(5)
                        .background(task.priority.color)
                        .cornerRadius(6)

                }
                
            }
            .frame(width: 150, height: 100, alignment: .leading)

        }
    }
    
}
#Preview {
    
    let subject = Subject(exams: [], subjectName: "Matemática", professorName: "", professorEmail: "", subjectDescription: "", subjectSchedule: [], absences: 0, absencesTime: .time1, subjectColor: .vermelho)
    
    let task = UserTask(id: UUID(), taskName: "Fazer lista", priority: .low, subject: subject, dateLimit: .now, notes: "", status: .done)
        
    TaskDetail(task: task)
}
