//
//  TaskDetailView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// INFORMAÇÕES DA VISUALIZAÇÃO DA TAREFA COMO O QUADRADO
import SwiftUI

struct TaskDetailView: View {
    
    let taskTittle: String
    let taskDescription: String
    let color: Color
    let taskTags: String


    var body: some View {
                
        GroupBox {
            VStack(alignment: .leading) {
                
                                    
                    Text(taskTittle)
                        .font(.title3)
                        .fontWeight(.bold)
                        .lineLimit(2)
                
                HStack {
                    
                    Text(taskTags)
                        .font(.footnote)
                        .fontWeight(.light)
                        .padding(5)
                        .background(color.secondary)
                        .cornerRadius(6)
                    
                    Text("Leitura")
                        .font(.footnote)
                        .fontWeight(.light)
                        .padding(5)
                        .background(.blue.secondary)
                        .cornerRadius(6)

                }
                
            }
            .frame(width: 150, height: 100, alignment: .leading)

        }
    }
    
}
#Preview {
    TaskDetailView(taskTittle: "Teste de título longo porque contem muitas palvras para ver se o text se corta", taskDescription: "TaskDescription" , color: .orange, taskTags: "História")
}
