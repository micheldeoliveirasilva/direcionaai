//
//  SubjectListView.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 26/06/26.
//

import SwiftUI
import SwiftData

struct SubjectListView: View {
    
    @Query
    private var subjects: [Subject]

    @Query
    private var extracurricularActivities: [ExtracurricularActivity]
    
    @State private var showAddSubject = false
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 32) {
                                        
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Disciplinas")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        if subjects.isEmpty {
                            Text("Nenhuma disciplina adicionada.")
                                .foregroundStyle(.secondary)
                        }
                        
                        VStack(spacing: 10) {
                            
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
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding()
                                    .background(.thinMaterial)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 14)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                    // ATIVIDADES EXTRACURRICULARES
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text("Atividades extracurriculares")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        if extracurricularActivities.isEmpty {
                            Text("Nenhuma atividade adicionada.")
                                .foregroundStyle(.secondary)
                        }
                        
                        VStack(spacing: 10) {
                            
                            ForEach(extracurricularActivities) { activity in
                                
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
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.footnote)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding()
                                    .background(.thinMaterial)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 14)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Disciplinas")
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
                ExtracurricularActivity.self
            ],
            inMemory: true
        )
}
