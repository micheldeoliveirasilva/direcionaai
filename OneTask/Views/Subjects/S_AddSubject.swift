//
//  S_AddSubject.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 26/06/26.
//

import SwiftUI
import SwiftData

struct S_AddSubject: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var subjectType: String = "Subject"
    
    //MARK: Variáveis do formulário - Genéricas
    @State private var name = ""
    @State private var description = ""
    @State private var schedule: [SubjectDay] = []
    @State private var selectedColor: SubjectColor = .rosa
    
    //MARK: Variáveis de formulário - Disciplina
    @State private var professorName = ""
    @State private var professorEmail = ""
    @State private var selectedTime: HourAbsences = .time3
    
    //MARK: Variáveis temporárias para os pickers de Schedule
    @State private var selectedDay: WeekDay = .qua
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date().addingTimeInterval(3600)
    
    //MARK: Função de salvar
    private func saveSubject() {
        
        if subjectType == "Subject" {
            
            let newSubject = Subject(
                exams: [],
                subjectName: name,
                professorName: professorName,
                professorEmail: professorEmail,
                subjectDescription: description,
                subjectSchedule: schedule,
                absences: 0,
                absencesTime: selectedTime,
                subjectColor: selectedColor
            )
            
            modelContext.insert(newSubject)
        }
        
        else {
            let newActivity = ExtracurricularActivity(
                name: name,
                activitySchedule: schedule,
                activityDescription: description,
                activityColor: selectedColor
            )
            
            modelContext.insert(newActivity)
        }
        
        dismiss()
    }
    
    private var isFormValid: Bool {
        
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
        
        if subjectType == "Subject" {
            return !description.isEmpty && !schedule.isEmpty
        }
        else {
            return !schedule.isEmpty
        }
    }
    
    // MARK: Schedule
    @ViewBuilder
    private var schedulePickerRow: some View {
        HStack(){
            
            Picker("Dia", selection: $selectedDay){
                ForEach(WeekDay.allCases, id: \.self){ day in
                    Text(day.rawValue).tag(day)
                }
            }
            .pickerStyle(.menu)
            .labelsHidden()
            
            Spacer(minLength: 0)
            
            DatePicker("", selection: $startTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(.compact)
            
            Text("às")
                .foregroundColor(.secondary)
                .font(.subheadline)
            
            DatePicker("", selection: $endTime, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(.compact)
            
            Spacer(minLength: 0.5)
            
            Button(action: addSchedule){
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .buttonStyle(.plain)
            
        }
    }
    
    @ViewBuilder
    private func addedScheduleRow(for item: SubjectDay) -> some View {
        HStack{
            Text(item.day.rawValue)
                .bold()
                .frame(width: 50, alignment: .leading)
            
            Text("\(item.startTime, style: .time) até \(item.endTime, style: .time)")
                .font(.body)
            
            Spacer()
        }
    }
    
    private func addSchedule() {
        let newSchedule = SubjectDay(day: selectedDay, startTime: startTime, endTime: endTime)
        
        if !schedule.contains(newSchedule) {
            schedule.append(newSchedule)
        }
    }
    
    private func removeSchedule(at offsets: IndexSet) {
        schedule.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
                        
            Form {
                
                Picker("", selection: $subjectType) {
                    Text("Disciplina").tag("Subject")
                    Text("Extracurricular").tag("Activity")
                }
                .pickerStyle(.segmented)
                
                TextField("Nome", text: $name)
                            
                if subjectType == "Subject" {
                    
                    Picker("Duração da Disciplina", selection: $selectedTime) {
                        ForEach(HourAbsences.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    TextField("Nome do Professor", text: $professorName)
                    
                    TextField("Email do Professor", text: $professorEmail)
                    
                }
                
                // Schedule
                Section(header: Text("Data e Hora")) {
                    schedulePickerRow
                    
                    
                    if !schedule.isEmpty {
                        Section(header: Text("Horários Adicionados")){
                            ForEach(schedule, id: \.self){ item in
                                addedScheduleRow(for: item)
                            }
                            .onDelete(perform: removeSchedule)
                        }
                    }
                }
                
                Section(header: Text("Detalhes")) {
                    
                    Picker("Cor", selection: $selectedColor) {
                        ForEach(SubjectColor.allCases, id: \.self) {
                            Text($0.rawValue.capitalized).tag($0)
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section(header: Text("Descrição")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Fechar", systemImage: "xmark")
                    }
                }
                
                ToolbarItem(placement: .principal){
                    Text(subjectType == "Subject" ? "Criar Disciplina" : "Criar Atividade")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: saveSubject) {
                        Label("Salvar", systemImage: "checkmark")
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}

#Preview {
    S_AddSubject()
}
