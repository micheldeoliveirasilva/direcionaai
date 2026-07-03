//
//  SwiftUIView.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 02/07/26.
//

import SwiftUI
import SwiftData

struct OnboardingAddSubjectView: View {
    
    @Binding var completeLaunch: Bool
    
    @Query private var activities: [ExtracurricularActivity]
    @Query private var subjects: [Subject]
    @Environment(\.modelContext) private var modelContext
    
    @State private var showSheet: Bool = false
    
    @ViewBuilder
    private func addedSubjectRow(for subject: Subject) -> some View {
        
        HStack{
            RoundedRectangle(cornerRadius: 4)
                .fill(subject.subjectColor.color)
                .frame(width: 8, height: 80)
            
            Text(subject.subjectName)
                .font(.body)
        }
    }
    
    private func removeSubject(at offsets: IndexSet) {
        for index in offsets {
            let subjectToDelete = subjects[index]
            modelContext.delete(subjectToDelete)
        }
    }
    
    @ViewBuilder
    private func addedActivityRow(for activity: ExtracurricularActivity) -> some View {
        
        HStack{
            RoundedRectangle(cornerRadius: 4)
                .fill(activity.activityColor.color)
                .frame(width: 8, height: 80)
            
            Text(activity.name)
                .font(.body)
        }
    }
    
    private func removeActivity(at offsets: IndexSet) {
        for index in offsets {
            let activityToDelete = activities[index]
            modelContext.delete(activityToDelete)
        }
    }
    
    var body: some View {
        
        VStack() {
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Adicione suas disciplinas:")
                    .font(.title.bold())
                    .padding(.horizontal)
                
                // Disciplinas
                if !subjects.isEmpty ||  !activities.isEmpty {
                    List {
                        
                        Section(header: Text("Disciplinas Adicionadas")) {
                            ForEach(subjects, id: \.self) { subject in
                                addedSubjectRow(for: subject)
                            }
                            .onDelete(perform: removeSubject)
                        }
                        
                        if subjects.isEmpty {
                            Text("Nenhuma disciplina adicionada.")
                                .foregroundStyle(.secondary)
                        }
                        
                        Section(header: Text("Extracurriculares Adicionadas")) {
                            ForEach(activities, id: \.self) { activity in
                                addedActivityRow(for: activity)
                            }
                            .onDelete(perform: removeActivity)
                        }
                        
                        if activities.isEmpty {
                            Text("Nenhuma disciplina adicionada.")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .listStyle(.plain)
                    
                } else {
                    ContentUnavailableView(
                        "Nenhuma Disciplina",
                        systemImage: "book.closed",
                        description: Text("Adicione pelo menos uma para continuar."))
                }
                
                Button(action: {
                    showSheet.toggle()
                }) {
                    Label("Adicionar disciplina", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            Button(action: {
                completeLaunch = true
            }) {
                Label("Finalizar Configuração", systemImage: "checkmark")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(subjects.isEmpty ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(subjects.isEmpty)
            .padding()
        }
        .sheet(isPresented: $showSheet) {
            S_AddSubject()
        }
    }
}
