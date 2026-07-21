//
//  ArchTasksView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//


// TELA DA ATIVIDADES ARQUIVADAS
import SwiftUI
import SwiftData

struct ArchTasksView: View {
    
    @Query var tasks: [userTask]
    @State private var selectedTask: userTask?
    @State private var currentDetent: PresentationDetent = .medium
    
    private var toDoTasks: [userTask] {
        tasks.filter { $0.status == .archived }
    }
    
    var body: some View {
        
        ScrollView {
            
            HStack {
                
                ForEach(toDoTasks) { task in
                    
                    TaskDetail(task: task)
                        .onTapGesture {
                            selectedTask = task
                        }
                        .frame(width: 150, height: 100)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                
            }
            
        }
        .padding(10)
        .navigationTitle("Arquivados")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedTask) { task in
            S_Task(actualDetent: $currentDetent, existTask: task)
        }
    }
}

#Preview {
    ArchTasksView()
}
