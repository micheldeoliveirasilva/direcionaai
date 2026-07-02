//
//  SwiftUIView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// TABVIEW DE TAREFAS, DISCIPLINA E SEARCH
import SwiftUI

struct
TabViewStruct: View {
    var body: some View {
        
        TabView {
            
            Tab("Tarefas", systemImage: "checklist") {
                TaskView()
            }
            
            
            Tab("Disciplinas", systemImage: "graduationcap") {
                SubjectView()
            }
            
            
            Tab("Pesquisar", systemImage: "magnifyingglass", role: .search) {
                
            }
            
        }
    }
    
}

#Preview {
    TabViewStruct()
}
