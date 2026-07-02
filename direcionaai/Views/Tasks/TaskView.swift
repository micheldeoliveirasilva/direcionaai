//
//  TaskView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// TELA PRINCIPAL DE TAREFAS
import SwiftUI
import SwiftData

struct TaskView: View {
    @State private var S_addTask = false;
    @State private var currentDetent: PresentationDetent = .medium
    
    
    @Query var tasks: [UserTask]
    // busca no swiftData as tasks armazenadas no model UserTask

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
                            
                            
                            ForEach(tasks) { task in
                                if task.status == .toDo {
                                    TaskDetail(task: task)
                                }
                            }
                            // percore e cria cada task exibindo dentro do molde criado em TaskDetailView e filtrando pelo status

                                
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
                                
                                ForEach(tasks) { task in
                                    if task.status == .inProgress {
                                        TaskDetail(task: task)
                                    }
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Concluído")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding()
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack {ForEach(tasks) { task in
                                    if task.status == .done {
                                        TaskDetail(task: task)
                                    }
                                }
                                    
                                }
                            }
                        }
                        
                    }
                    .padding(10)
                    .navigationTitle("Tarefas")
                    .toolbar{
                        
                        ToolbarItem(placement: .topBarTrailing){
                            NavigationLink{
                                ArchTasksView()
                            } label : {
                                Image(systemName: "archivebox.fill")
                            }
                            
                        }
                        
                        ToolbarSpacer(.flexible, placement: .topBarTrailing)
                        
                        ToolbarItem(placement: .topBarTrailing){
                            Button(action: {
                                S_addTask.toggle()
                            }) {
                                Label("Adicionar tarefa", systemImage: "plus")
                            }
                        }
                        
                        ToolbarItem(placement: .topBarLeading){
                            Button(action: {
                                print("Visualizar lembretes")
                            }) {
                                Label("Lembretes", systemImage: "bell.fill")
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
    }


#Preview {
    
    TaskView()
}
