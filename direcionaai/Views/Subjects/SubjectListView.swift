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
    
    @Query
    private var activities: [ExtracurricularActivity]
    
    @State private var showAddSubject = false
    @State private var S_addTask: Bool = false
    @State private var currentDetent: PresentationDetent = .medium
    
    private func removeSubject(at offsets: IndexSet) {
        for index in offsets {
            let subjectToDelete = subjects[index]
            modelContext.delete(subjectToDelete)
        }
    }
    
    private func removeActivity(at offsets: IndexSet) {
        for index in offsets {
            let activityToDelete = activities[index]
            modelContext.delete(activityToDelete)
        }
    }
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
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
                                SubjectView(
                                    subject: subject,
//                                    S_addTask: $S_addTask,
//                                    currentDetent: $currentDetent
                                )
                                
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
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                        }
                        .onDelete(perform: removeSubject)
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
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                            }
                            .buttonStyle(.plain)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                        }
                        .onDelete(perform: removeActivity)
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
        }
    }
}

#Preview {
    SubjectListView()
        .modelContainer(
            for: [
                Subject.self,
                ExtracurricularActivity.self,
                UserTask.self
            ],
            inMemory: true
        )
}
