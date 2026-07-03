//
//  OnboardingView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// TELA DE INTRODUÇÃO DO APP
import SwiftUI

struct OnboardingView: View {
    
    @Binding var completeLaunch: Bool
    
    var body: some View {
        NavigationStack{
            ZStack {
                
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.60),
                        Color.blue.opacity(0.1),
                        Color(.clear)],
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 190)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Bem-vindo(a) ao")
                            .font(Font.largeTitle.bold())
                        
                        Text("Direciona-Aí")
                            .font(Font.largeTitle.bold())
                            .foregroundStyle(Color.blue)
                    }
                    Spacer()
                        .frame(height: 40)
                    
                    VStack(spacing: 40) {
                        
                        HStack(alignment: .top, spacing: 20){
                            
                            Image(systemName: "calendar")
                                .font(Font.system(size: 23, weight: .bold, design: .rounded))
                                .foregroundColor(.blue)
                                .font(.headline)
                                .frame(width: 30, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5){
                                
                                Text("Não perca prazos")
                                    .font(.title3)
                                    .bold()
                                
                                Text("Fique atento aos prazos dos seus trabalhos e avaliações.")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        HStack(alignment: .top, spacing: 20){
                            
                            Image(systemName: "target")
                                .font(Font.system(size: 23, weight: .bold, design: .rounded))
                                .foregroundColor(.blue)
                                .font(.headline)
                                .frame(width: 30, height: 50)
                            
                            VStack(alignment: .leading, spacing: 5){
                                
                                Text("Registre suas atividades")
                                    .font(.title3)
                                    .bold()
                                
                                Text("Acompanhe o progresso das suas atividades e estudos.")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        
                    }
                    Spacer()
                    
                    NavigationLink {
                        OnboardingAddSubjectView(completeLaunch: $completeLaunch)
                    } label: {
                        Text("Começar")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.vertical, 17)
                            .padding(.horizontal, 119)
                            .background(.blue)
                            .clipShape(Capsule())
                    }
                    
                }
                .padding(.horizontal, 35)
            }
        }
    }
}
