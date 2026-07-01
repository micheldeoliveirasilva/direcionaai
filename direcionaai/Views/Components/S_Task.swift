//
//  S_AddTask.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 26/06/26.
//

import SwiftUI

struct S_Task: View {
    @Environment(\.dismiss) var dismiss
    @Binding var actualDetent: PresentationDetent // Captura o tamanho da sheet
    
    // var existTask: Task? -> Usando o Model da Task

    //MARK: Variáveis do formulário (medium)
    
    @State private var taskName = ""
    // @State private var categoria = "Atividade" -> Trocar pela prioridade?
    @State private var priority = "Média"
    @State private var subject = "ADA"
    @State private var dateLimit = Date()
    // @State private var alert = false -> Faz sentido ter um botão que escolha se quer ser alertado?
    
    let prioritys = ["Baixa", "Média", "Alta"]
    let subjects = ["ADA", "Machine Learning",  "Cálculo I", "Fonética e fonologia"]
    
    //MARK: Variáveis do formulário (large)
    
    @State private var notes = ""
    
    var body: some View {
        
        NavigationStack{
            
            Form{
                
                Section(header: Text("Criar Atividade")){
                    TextField("Nome", text: $taskName)
                    
                    Picker("Prioridade", selection: $priority){
                        ForEach(prioritys, id: \.self) {Text($0)}
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Disciplina", selection: $subject){
                        ForEach(subjects, id: \.self) {Text($0)}
                    }
                    .pickerStyle(.menu)
                    
                    DatePicker("Data de Entrega", selection: $dateLimit, displayedComponents: .date)
                }
                
                if actualDetent == .large {
                    
                    Section(header: Text("Informações adicionais")){
                        
                        VStack(alignment: .leading){
                            Text("Notas adicionais")
                                .font(.caption)
                                .foregroundColor(.gray)
                            TextEditor(text: $notes)
                                .frame(height: 150)
                        }
                    }
                    
                    if true { //existTask != nil
                        
                        Button(role: .destructive){
                            dismiss()
                        } label : {
                            HStack {
                                Spacer()
                                Text("Arquivar Nota")
                                Spacer()
                            }
                        }
                    }
                    
                }
                
            }
//            .onAppear{
//                if let task = existTask {
//                    taskName = task.taskName
//                    priority = task.priority
//                    subject = task.subject
//                    dateLimit = task.dateLimit
//                    notes = task.notes
//                }
//            }
            .toolbar {
                
                ToolbarItem(placement: .principal){
                    Text("Adicionar tarefa") //existTask == nil ? "Adicionar tarefa" : "Editar Nota")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                ToolbarItem(placement: .topBarLeading) { // Não sei se precisa ter
                    Button(action: {
                        dismiss()
                    }){
                        Label("Fechar", systemImage: "xmark")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("Alterar para salvar")
                    }){
                        Label("Salvar", systemImage: "checkmark")
                    }
                    .disabled(taskName.isEmpty)
                }
            }
            
        }
        
    }
}

#Preview {
    S_Task(actualDetent: .constant(.large))
}
