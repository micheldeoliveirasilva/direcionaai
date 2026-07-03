//
//  OnboardingView.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 25/06/26.
//

// TELA DE INTRODUÇÃO DO APP
import SwiftUI

struct OnboardingView: View {
    
    @State private var showNextPage = false

    var body: some View {
        
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                
                
                VStack(alignment: .leading, spacing: -5) {
                    Text("Bem-vindo(a) ao")
                        .font(Font.largeTitle.bold())
                    Text("Direciona-Aí")
                        .font(Font.largeTitle.bold())
                        .foregroundStyle(Color.blue)
                }
                .padding(10)
                
                VStack(alignment: .leading) {
                    Text("\(Image(systemName: "calendar")) Não perca prazos")
                        .font(Font.title.bold())
                    
                    Text("Fique atento aos prazos dos seus trabalhos e avaliações.")
                        .font(Font.headline)
                        .fontWeight(Font.Weight.light)
                }
                .padding(15)
                
                VStack(alignment: .leading) {
                    
                    Text("\(Image(systemName: "target")) Registre suas atividades")
                        .font(Font.title.bold())
                    Text("Acompanhe seu progresso nas atividades.")
                        .font(Font.headline)
                        .fontWeight(Font.Weight.light)
                    
                }
                .padding(10)
                
            }
            
            Button("Continuar"){
                showNextPage.toggle()
            }
            .foregroundStyle(Color.white)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .fullScreenCover(isPresented: $showNextPage) {
                TabViewStruct()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [.white, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(0.5))
            .ignoresSafeArea()
    }
    
    
}

#Preview {
    OnboardingView()
}
