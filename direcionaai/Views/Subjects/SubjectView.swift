//
//  SubjectView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

import SwiftUI
import SwiftData

struct SubjectView: View {
    
    @Bindable var subject: Subject
    
    @Query private var tasks: [UserTask]
    
    // Sheets
    @State private var showAddTask = false
    @State private var showAddExam = false
    
    // Tamanho do sheet de tarefa
    @State private var currentDetent: PresentationDetent = .medium
    
    var subjectTasks: [UserTask] {
        tasks.filter { task in
            task.subject == subject
        }
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 28) {
                
                // MARK: - Informações da disciplina
                
                HStack {
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(subject.subjectColor.color)
                        .frame(width: 8, height: 80)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(subject.subjectName)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        if !subject.subjectDescription.isEmpty {
                            
                            Text(subject.subjectDescription)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                Divider()
                
                // MARK: - Professor
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Professor")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if !subject.professorName.isEmpty {
                        Text(subject.professorName)
                    }
                    
                    if !subject.professorEmail.isEmpty {
                        Text(subject.professorEmail)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Divider()
                
                // MARK: - Horários
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    Text("Horários")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if subject.subjectSchedule.isEmpty {
                        
                        Text("Nenhum horário adicionado.")
                            .foregroundStyle(.secondary)
                        
                    } else {
                        
                        ForEach(subject.subjectSchedule, id: \.self) { schedule in
                            
                            HStack {
                                
                                Text(schedule.day.rawValue)
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Text(
                                    "\(schedule.startTime.formatted(date: .omitted, time: .shortened)) – \(schedule.endTime.formatted(date: .omitted, time: .shortened))"
                                )
                                .foregroundStyle(.secondary)
                            }
                            
                            Divider()
                        }
                    }
                }
                
                // MARK: - Tarefas
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        
                        Text("Tarefas")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            currentDetent = .medium
                            showAddTask = true
                        } label: {
                            Label("Adicionar", systemImage: "plus")
                        }
                    }
                    
                    if subjectTasks.isEmpty {
                        
                        Text("Nenhuma tarefa adicionada.")
                            .foregroundStyle(.secondary)
                        
                    } else {
                        
                        ForEach(subjectTasks) { task in
                            
                            HStack {
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text(task.taskName)
                                        .font(.headline)
                                    
                                    Text(task.status.rawValue)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.vertical, 6)
                            
                            Divider()
                        }
                    }
                }
                
                Divider()
                
                // MARK: - Avaliações
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        
                        Text("Avaliações")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            showAddExam = true
                        } label: {
                            Label("Adicionar", systemImage: "plus")
                        }
                    }
                    
                    if subject.exams.isEmpty {
                        
                        Text("Nenhuma avaliação adicionada.")
                            .foregroundStyle(.secondary)
                        
                    } else {
                        
                        ForEach(
                            Array(subject.exams.enumerated()),
                            id: \.offset
                        ) { _, exam in
                            
                            VStack(spacing: 10) {
                                
                                HStack {
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        
                                        Text(exam.assesmentsName)
                                            .fontWeight(.medium)
                                        
                                        Text(
                                            exam.assesmentsDate.formatted(
                                                date: .abbreviated,
                                                time: .omitted
                                            )
                                        )
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(
                                        exam.assessments,
                                        format: .number.precision(
                                            .fractionLength(1)
                                        )
                                    )
                                    .font(.title3)
                                    .foregroundStyle(.blue)
                                }
                                
                                Divider()
                            }
                        }
                    }
                }
                
                Divider()
                
                // MARK: - Faltas
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text("Faltas")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text(
                                "\(subject.absencesTime.rawValue) – \(subject.absencesTime.totalAbsenses) faltas possíveis"
                            )
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 0) {
                            
                            Button {
                                if subject.absences > 0 {
                                    subject.absences -= 1
                                }
                            } label: {
                                Image(systemName: "minus")
                                    .frame(width: 44, height: 38)
                            }
                            
                            Divider()
                                .frame(height: 24)
                            
                            Button {
                                if subject.absences < subject.absencesTime.totalAbsenses {
                                    subject.absences += 1
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .frame(width: 44, height: 38)
                            }
                        }
                        .background(.quaternary)
                        .clipShape(Capsule())
                    }
                    
   ProgressView(
    value: Double(subject.absences),
    total: Double(subject.absencesTime.totalAbsenses)
)
.tint(
    Double(subject.absences)
    >= Double(subject.absencesTime.totalAbsenses) * 0.7
    ? .red
    : .blue
)
                    
                    HStack {
                        
                        Text("\(subject.absences)")
                        
                        Spacer()
                        
                        Text("\(subject.absencesTime.totalAbsenses)")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    
Text("\(subject.absences) faltas registradas")
    .font(.headline)
    .foregroundStyle(
        Double(subject.absences)
        >= Double(subject.absencesTime.totalAbsenses) * 0.7
        ? .red
        : .primary
    )
    .frame(maxWidth: .infinity)
                }
            }
            .padding(20)
        }
        .navigationTitle("Disciplina")
        .navigationBarTitleDisplayMode(.inline)
        
        // Sheet de tarefa
        
        .sheet(isPresented: $showAddTask) {
            
            S_Task(actualDetent: $currentDetent)
                .presentationDetents(
                    [.medium, .large],
                    selection: $currentDetent
                )
        }
        
        // Sheet de avaliação
        
        .sheet(isPresented: $showAddExam) {
            AddExamView(subject: subject)
        }
    }
}

#Preview("Disciplina") {
    
    NavigationStack {
        
        SubjectView(
            subject: Subject(
                exams: [
                    Exams(
                        assesmentsDate: .now,
                        assessments: 10,
                        assesmentsName: "Prova 1"
                    ),
                    Exams(
                        assesmentsDate: .now,
                        assessments: 8.5,
                        assesmentsName: "Trabalho"
                    )
                ],
                subjectName: "Fonética e fonologia",
                professorName: "Maria Silva",
                professorEmail: "maria@ufpe.br",
                subjectDescription: "Estudo dos sons da fala e da organização sonora da língua.",
                subjectSchedule: [
                    SubjectDay(
                        day: .seg,
                        startTime: .now,
                        endTime: .now
                    ),
                    SubjectDay(
                        day: .qua,
                        startTime: .now,
                        endTime: .now
                    )
                ],
                absences: 10,
                absencesTime: .time3,
                subjectColor: .azul
            )
        )
    }
    .modelContainer(
        for: [
            Subject.self,
            UserTask.self
        ],
        inMemory: true
    )
}
