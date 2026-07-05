//
//  S_AddTask.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 26/06/26.
//

import SwiftUI
import SwiftData

struct S_Task: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Binding var actualDetent: PresentationDetent // Captura o tamanho da sheet
    
    @Query var allSubjects: [Subject] // Captura as disciplinas salvas
    
    var existTask: UserTask?
    
    //MARK: Variáveis do formulário (medium)
    @State private var taskName = ""
    @State private var selectedSubject: Subject?
    @State private var selectedPriority: Priority = .medium
    @State private var dateLimit = Date()
    
    let subjects = ["Teste", "Teste 2"]
    
    //MARK: Variáveis do formulário (large)
    @State private var notes = ""
    
    //MARK: Função de salvar
    private func saveTask() {
        guard let safeSubject = selectedSubject else { return }
        
        if let task = existTask {
            // Modo Edição
            task.taskName = taskName
            task.priority = selectedPriority
            task.subject = safeSubject
            task.dateLimit = dateLimit
            task.notes = notes
        } else {
            // Modo Criação
            let newTask = UserTask(id: UUID(), taskName: taskName, priority: selectedPriority, subject: safeSubject, dateLimit: dateLimit, notes: "", status: .toDo)
            modelContext.insert(newTask)

            print("Inseriu:", newTask.taskName)
            print("Quantidade:", allSubjects.count)
        }
        
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Criar Atividade")) {
                    TextField("Nome", text: $taskName)
                    
                    Picker("Prioridade", selection: $selectedPriority) {
                        ForEach(Priority.allCases, id: \.self) {
                            Text($0.rawValue.capitalized).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Disciplina", selection: $selectedSubject) {
                        Text("Selecione uma disciplina").tag(nil as Subject?)
                        
                        ForEach(allSubjects) { subject in
                            Text(subject.subjectName).tag(subject as Subject?)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    DatePicker("Data de Entrega", selection: $dateLimit, displayedComponents: .date)
                }
                
                if actualDetent == .large {
                    Section(header: Text("Informações adicionais")) {
                        VStack(alignment: .leading) {
                            Text("Notas adicionais")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextEditor(text: $notes)
                                .frame(height: 150)
                        }
                    }
                    
                    if let task = existTask {
                        Button(role: .destructive) {
                            task.status = .archived
                            dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Arquivar Nota")
                                Spacer()
                            }
                        }
                    }
                }
            }
            .onAppear {
                if let task = existTask {
                    taskName = task.taskName
                    self.selectedPriority = task.priority
                    self.selectedSubject = task.subject
                    dateLimit = task.dateLimit
                    notes = task.notes
                }
                else {
                    self.selectedSubject = allSubjects.first
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    Text(existTask == nil ? "Adicionar tarefa" : "Editar Nota")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Fechar", systemImage: "xmark")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: saveTask) {
                        Label("Salvar", systemImage: "checkmark")
                    }
                    .disabled(taskName.isEmpty || selectedSubject == nil)
                }
                
            }
        }
    }
}

#Preview {
    S_Task(actualDetent: .constant(.large))
}
