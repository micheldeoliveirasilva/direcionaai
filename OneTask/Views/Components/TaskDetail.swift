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
                
                Text(task.notes)
                
                HStack {
                    
                    if let subject = task.subject {
                        let themeColor = subject.subjectColor.color
                        
                        Text(subject.subjectName)
                            .bold()
                            .font(.footnote)
//                            .fontWeight(.light)
                            .padding(5)
                            .foregroundStyle(themeColor)
                            .background(themeColor.opacity(0.1))
                            .cornerRadius(6)
                            .fixedSize(horizontal: true, vertical: false)
                            
                    } else if let activity = task.activity {
                        let themeColor = activity.activityColor.color
                        
                        Text(activity.name)
                            .bold()
                            .font(.footnote)
//                            .fontWeight(.light)
                            .padding(5)
                            .foregroundStyle(themeColor)
                            .background(themeColor.opacity(0.1))
                            .cornerRadius(6)
                            .fixedSize(horizontal: true, vertical: false)
                    }
                    
                    let priorityColor = task.priority.color
                    Text(task.priority.rawValue)
                        .bold()
                        .font(.footnote)
//                        .fontWeight(.light)
                        .padding(5)
                        .foregroundStyle(priorityColor)
                        .background(priorityColor.opacity(0.1))
                        .cornerRadius(6)
                        .fixedSize(horizontal: true, vertical: false)
                    
                }
                
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
    
}
//#Preview {
//    
//    let subject = Subject(exams: [], subjectName: "Matemática", professorName: "", professorEmail: "", subjectDescription: "", subjectSchedule: [], absences: 0, absencesTime: .time1, subjectColor: .vermelho)
//    
//    let task = UserTask(id: UUID(), taskName: "Fazer lista", priority: .low, subject: .subject(subject), dateLimit: .now, notes: "Atividade de Máximos e Mínimos", status: .done)
//    
//    TaskDetail(task: task)
//}
