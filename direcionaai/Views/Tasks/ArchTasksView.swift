//
//  ArchTasksView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//


// TELA DA ATIVIDADES ARQUIVADAS
import SwiftUI

struct ArchTasksView: View {
    var body: some View {
      
        ScrollView {
            VStack(alignment: .leading) {
                Text("Arquivados")
                    
            }
            
        }
        .padding(10)
        .navigationTitle("Arquivados")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    ArchTasksView()
}
