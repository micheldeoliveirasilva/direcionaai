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
    
    @Environment(\.modelContext) var modelContext
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


#Preview {
    
        let subject = Subject(exams: [], subjectName: "Matemática", professorName: "", professorEmail: "", subjectDescription: "", subjectDay: "", startTime: .now, endTime: .now, absences: 0)
        
        let task = UserTask(taskName: "Fazer lista", priority: .high, subject: subject, dateLimit: .now, notes: "", progress: "", status: .done)
        
    TaskView()
}
