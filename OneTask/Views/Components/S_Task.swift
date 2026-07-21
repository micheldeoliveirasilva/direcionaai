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
    @Query var allActivities: [ExtracurricularActivity]
    
    var existTask: UserTask?
    
    //MARK: Variáveis do formulário (medium)
    @State private var taskName = ""
    @State private var selectedSubject: TaskSubject?
    @State private var selectedPriority: Priority = .medium
    @State private var selectedstatus: Status = .toDo
    @State private var dateLimit = Date()
    
    //MARK: Variáveis do formulário (large)
    @State private var notes = ""
    
    //MARK: Função de salvar
    private func saveTask() {
        
        guard let safeSubject = selectedSubject else { return }

        let subjectToSave: Subject?
        let activityToSave: ExtracurricularActivity?
        
        switch safeSubject {
        case .subject(let s):
            subjectToSave = s
            activityToSave = nil
        case .activity(let a):
            subjectToSave = nil
            activityToSave = a
        }
        
        if let task = existTask {
            // Modo Edição
            task.taskName = taskName
            task.priority = selectedPriority
            task.subject = subjectToSave
            task.activity = activityToSave
            task.dateLimit = dateLimit
            task.notes = notes
            
        } else {
            // Modo Criação
            let newTask = UserTask(
                id: UUID(),
                taskName: taskName,
                priority: selectedPriority,
                subject: subjectToSave,
                activity: activityToSave,
                dateLimit: dateLimit,
                notes: notes,
                status: .toDo
            )
            modelContext.insert(newTask)
            
            print("Inseriu:", newTask.taskName)
            print("Quantidade:", allSubjects.count)
        }
        
        dismiss()
    }
    
    //MARK: Função de apagar task
    private func deleteTask(_ task: UserTask) {
        modelContext.delete(task)
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
                        Text("Selecione uma disciplina").tag(nil as TaskSubject?)
                        
                        Section(header: Text("Disciplinas")) {
                            ForEach(allSubjects) { subject in
                                Text(subject.subjectName)
                                    .tag(TaskSubject.subject(subject) as TaskSubject?)
                            }
                        }
                        
                        Section(header: Text("Extracurriculares")) {
                            ForEach(allActivities) { activity in
                                Text(activity.name)
                                    .tag(TaskSubject.activity(activity) as TaskSubject?)
                            }
                        }
                        
                    }
                    .pickerStyle(.menu)
                    
                    DatePicker("Data de Entrega", selection: $dateLimit, displayedComponents: .date)
                }
                
                if actualDetent == .large {
                    
                    Picker("Status", selection: $selectedstatus) {
                        ForEach(Status.allCases, id: \.self) {
                            Text($0.rawValue.capitalized).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
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
                        
                        Button(role: .destructive) {
                            deleteTask(task)
                            dismiss()
                        } label: {
                            HStack {
                                Spacer()
                                Text("Excluir Nota")
                                Spacer()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .onAppear {
                if let task = existTask {
                    taskName = task.taskName
                    self.selectedPriority = task.priority
                    
                    if let sub = task.subject {
                        self.selectedSubject = .subject(sub)
                    } else if let act = task.activity {
                        self.selectedSubject = .activity(act)
                    } else {
                        self.selectedSubject = nil
                    }
                    
                    dateLimit = task.dateLimit
                    notes = task.notes
                }
                else {
                    if let firstSubject = allSubjects.first {
                        self.selectedSubject = .subject(firstSubject)
                    } else {
                        self.selectedSubject = nil
                    }
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
