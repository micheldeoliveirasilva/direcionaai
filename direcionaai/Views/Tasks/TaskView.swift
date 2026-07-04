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
                                    .draggable(UserTaskTransfer(id: task.id))
                                }
                            }
                                                        // percore e cria cada task exibindo dentro do molde criado em TaskDetailView e filtrando pelo status
                            
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity, minHeight: 180)
                .contentShape(Rectangle())
                .dropDestination(for: UserTaskTransfer.self) { items, location in
                    
                    guard let transfer = items.first,
                          let draggedTask = tasks.first(where: { $0.id == transfer.id }) else {
                        return false
                    }

                    withAnimation(.snappy) {
                        draggedTask.status = .toDo
                    }
                    
                    print("DROP")
                    return true
                }
                
                VStack(alignment: .leading) {
                    Text("Em andamento")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack {ForEach(tasks) { task in
                            if task.status == .inProgress {
                                TaskDetail(task: task)
                                .draggable(UserTaskTransfer(id: task.id))
                            }
                        }
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 180)
                .contentShape(Rectangle())
                .dropDestination(for: UserTaskTransfer.self) { items, location in
                    
                    guard let transfer = items.first,
                          let draggedTask = tasks.first(where: { $0.id == transfer.id }) else {
                        return false
                    }

                    withAnimation(.snappy) {
                        draggedTask.status = .inProgress
                    }
                    
                    print("DROP")
                    return true
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
                                    .draggable(UserTaskTransfer(id: task.id))
                            }
                        }
                            
                        }
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 180)
                .contentShape(Rectangle())
                .dropDestination(for: UserTaskTransfer.self) { items, location in
                    
                    guard let transfer = items.first,
                          let draggedTask = tasks.first(where: { $0.id == transfer.id }) else {
                        return false
                    }

                    withAnimation(.snappy) {
                        draggedTask.status = .done
                    }
                    
                    print("DROP")
                    return true
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
                
                S_Task(actualDetent: $currentDetent)
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
        .modelContainer(
            for: [
                Subject.self,
                UserTask.self
            ],
            inMemory: true
        )
}
