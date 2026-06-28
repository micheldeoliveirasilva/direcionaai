//
//  TaskView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// TELA PRINCIPAL DE TAREFAS
import SwiftUI

struct TaskView: View {
    @State private var S_addTask = false;
    @State private var currentDetent: PresentationDetent = .medium
    
    var body: some View {
       
        NavigationStack{
            
            
            
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Para fazer")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            
                            TaskDetailView(taskTittle: "Fazer lista de história", taskDescription: "Realizar lista de tarefas", color: .orange, taskTags: "História")
                            
                            TaskDetailView(taskTittle: "Lembrar de fazer compras", taskDescription: "TaskDescription", color: .orange, taskTags: "História")
                            
                            TaskDetailView(taskTittle: "Estudar para prova", taskDescription: "TaskDescription", color: .orange, taskTags: "História")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Em andamento")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            
                            TaskDetailView(taskTittle: "Fazer lista de história", taskDescription: "Realizar lista de tarefas", color: .orange, taskTags: "História")
                            
                            TaskDetailView(taskTittle: "Lembrar de fazer compras", taskDescription: "TaskDescription", color: .orange, taskTags: "História")
                            
                            TaskDetailView(taskTittle: "Estudar para prova", taskDescription: "TaskDescription", color: .orange, taskTags: "História")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Concluído")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {
                            
                            TaskDetailView(taskTittle: "Fazer lista de história", taskDescription: "Realizar lista de tarefas", color: .orange, taskTags: "História")
                            
                            TaskDetailView(taskTittle: "Lembrar de fazer compras", taskDescription: "TaskDescription", color: .orange, taskTags: "História")
                            
                            TaskDetailView(taskTittle: "Estudar para prova", taskDescription: "TaskDescription", color: .orange, taskTags: "História")
                        }
                    }
                }
                
            }
            .padding(10)
                .navigationTitle("Tarefas")
                .toolbar{
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            S_addTask.toggle()
                        }) {
                            Label("Adicionar tarefa", systemImage: "archivebox.fill")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button(action: {
                            S_addTask.toggle()
                        }) {
                            Label("Adicionar tarefa", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $S_addTask) {
                    
                    S_AddTask(actualDetent: $currentDetent)
                        .presentationDetents([.medium, .large], selection: $currentDetent)
                        .presentationDragIndicator(.visible)
                        .onDisappear{
                            currentDetent = .medium
                        }
                }
    
        }
        
    }
}


#Preview {
    TaskView()
}
