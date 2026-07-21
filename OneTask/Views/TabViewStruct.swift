//
//  SwiftUIView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// TABVIEW DE TAREFAS, DISCIPLINA E SEARCH
import SwiftUI
import SwiftData

struct
TabViewStruct: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var searchText = ""
    
    // Visualizar task
    @State private var selectedTask: UserTask? = nil
    @State private var currentDetent: PresentationDetent = .medium
    
    // Filtar tasks
    @Query var tasks: [UserTask]
    
    var filteredTasks: [UserTask] {
        if searchText.isEmpty {
            return []
        } else {
            return tasks.filter { task in
                task.taskName.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        
        TabView {
            
            Tab("Tarefas", systemImage: "checklist") {
                TaskView()
            }
            
            
            Tab("Disciplinas", systemImage: "graduationcap") {
                SubjectListView()
            }
            
            
            Tab("Pesquisar", systemImage: "magnifyingglass", role: .search) {
                
                NavigationStack {
                    if filteredTasks.isEmpty && !searchText.isEmpty {
                        ContentUnavailableView.search(text: searchText)
                    } else {
                        
                        List{
                            
                            if !searchText.isEmpty {
                                HStack{
                                    
                                    Text("Atividades")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .listRowBackground(Color.clear)
                                    
                                    Spacer()
                                    
                                    Text("\(filteredTasks.count) Encontradas")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .listRowBackground(Color.clear)
                                }
                            }
                            
                            ForEach(filteredTasks) { task in
                                
                                Button(action: {
                                    selectedTask = task
                                }) {
                                    TaskDetail(task: task)
                                        .frame(height: 100)
                                }
                                .buttonStyle(.plain)
                            }
                            
                        }
                        .listStyle(.insetGrouped)
                        .navigationTitle("Buscar")
                        .sheet(item: $selectedTask) { showTask in
                            
                            S_Task(actualDetent: $currentDetent, existTask: showTask)
                            .presentationDetents([.medium, .large], selection: $currentDetent)
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Pesquisar por tarefa...")
                
            }
        }
        
    }
}

#Preview {
    TabViewStruct()
        .modelContainer(
            for: [
                UserTask.self,
                Subject.self,
                ExtracurricularActivity.self
            ], inMemory: true
        )
}
