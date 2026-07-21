//
//  SubjectListView.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 26/06/26.
//

import SwiftUI
import SwiftData

struct SubjectListView: View {
    
    @Environment(\.modelContext) private var modelContext

    @Query private var subjects: [Subject]
    @Query private var activities: [ExtracurricularActivity]
    
    @State private var showAddSubject = false
    @State private var S_addTask: Bool = false
    @State private var currentDetent: PresentationDetent = .medium
    
    // MARK: - Confirmação de exclusão
    
    private enum PendingDeletion {
        case subject(Subject)
        case activity(ExtracurricularActivity)
    }
    
    @State private var pendingDeletion: PendingDeletion?
    @State private var showDeleteConfirmation = false
    
    private var deleteAlertTitle: String {
        switch pendingDeletion {
        case .subject:
            return "Excluir disciplina?"
            
        case .activity:
            return "Excluir atividade?"
            
        case nil:
            return "Confirmar exclusão"
        }
    }
    
    private var deleteAlertMessage: String {
        switch pendingDeletion {
        case .subject(let subject):
            return """
            Tem certeza de que deseja excluir a disciplina "\(subject.subjectName)"?
            """
            
        case .activity(let activity):
            return """
            Tem certeza de que deseja excluir a atividade "\(activity.name)"?
            """
            
        case nil:
            return ""
        }
    }
    
    // Chamado quando a pessoa faz swipe na disciplina
    private func requestSubjectDeletion(at offsets: IndexSet) {
        guard let index = offsets.first else {
            return
        }
        
        pendingDeletion = .subject(subjects[index])
        showDeleteConfirmation = true
    }
    
    // Chamado quando a pessoa faz swipe na atividade
    private func requestActivityDeletion(at offsets: IndexSet) {
        guard let index = offsets.first else {
            return
        }
        
        pendingDeletion = .activity(activities[index])
        showDeleteConfirmation = true
    }
    
    // Só exclui depois da confirmação
    private func confirmDeletion() {
        guard let pendingDeletion else {
            return
        }
        
        switch pendingDeletion {
        case .subject(let subject):
            modelContext.delete(subject)
            
        case .activity(let activity):
            modelContext.delete(activity)
        }
        
        self.pendingDeletion = nil
    }
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                // MARK: - Disciplinas
                
                Section {
                    
                    if subjects.isEmpty {
                        Text("Nenhuma disciplina adicionada.")
                            .foregroundStyle(.secondary)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding()
                        
                    } else {
                        
                        ForEach(subjects) { subject in
                            
                            NavigationLink {
                                SubjectView(subject: subject)
                                
                            } label: {
                                HStack(spacing: 14) {
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(subject.subjectColor.color)
                                        .frame(width: 8, height: 42)
                                    
                                    Text(subject.subjectName)
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 14)
                                )
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 6,
                                    leading: 16,
                                    bottom: 6,
                                    trailing: 16
                                )
                            )
                        }
                        .onDelete(perform: requestSubjectDeletion)
                    }
                    
                } header: {
                    Text("Faculdade")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
                
                // MARK: - Atividades extracurriculares
                
                Section {
                    
                    if activities.isEmpty {
                        Text("Nenhuma atividade adicionada.")
                            .foregroundStyle(.secondary)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .padding()
                        
                    } else {
                        
                        ForEach(activities) { activity in
                            
                            NavigationLink {
                                ExtracurricularView(
                                    activity: activity
                                )
                                
                            } label: {
                                
                                HStack(spacing: 14) {
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(activity.activityColor.color)
                                        .frame(width: 8, height: 42)
                                    
                                    Text(activity.name)
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 14)
                                )
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(
                                EdgeInsets(
                                    top: 6,
                                    leading: 16,
                                    bottom: 6,
                                    trailing: 16
                                )
                            )
                        }
                        .onDelete(perform: requestActivityDeletion)
                    }
                    
                } header: {
                    Text("Extracurricular")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Disciplinas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button {
                        showAddSubject = true
                    } label: {
                        Label(
                            "Adicionar disciplina",
                            systemImage: "plus"
                        )
                    }
                }
            }
            .sheet(isPresented: $showAddSubject) {
                S_AddSubject()
            }
            .alert(
                deleteAlertTitle,
                isPresented: $showDeleteConfirmation
            ) {
                Button("Cancelar", role: .cancel) {
                    pendingDeletion = nil
                }
                
                Button("Excluir", role: .destructive) {
                    confirmDeletion()
                }
                
            } message: {
                Text(deleteAlertMessage)
            }
        }
    }
}

#Preview {
    SubjectListView()
        .modelContainer(
            for: [
                Subject.self,
                ExtracurricularActivity.self,
                userTask.self
            ],
            inMemory: true
        )
}
