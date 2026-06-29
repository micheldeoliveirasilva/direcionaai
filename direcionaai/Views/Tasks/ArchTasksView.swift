//
//  ArchTasksView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//


// TELA DA ATIVIDADES ARQUIVADAS
import SwiftUI

struct ArchTasksView: View {
    var body: some View {
      
        ScrollView {
            VStack(alignment: .leading) {
                
                TaskDetailView(taskTittle: "Fazer lista de história", taskDescription: "Realizar lista de tarefas", color: .orange, subjectTag: "História", priorityTag: "Média")
                
                TaskDetailView(taskTittle: "Lembrar de fazer compras", taskDescription: "TaskDescription", color: .orange, subjectTag: "História", priorityTag: "Média")
                
                TaskDetailView(taskTittle: "Estudar para prova", taskDescription: "TaskDescription", color: .orange, subjectTag: "História", priorityTag: "Média")
                    
            }
            
        }
        .padding(10)
        .navigationTitle("Arquivados")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    ArchTasksView()
}
