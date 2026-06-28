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
            
            Text("Atividades")
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
