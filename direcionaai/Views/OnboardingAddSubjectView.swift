//
//  SwiftUIView.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 02/07/26.
//

import SwiftUI

struct OnboardingAddSubjectView: View {
    
    @State private var showNextPage = false
    
    var body: some View {
        
        VStack() {
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Adicione suas disciplinas:")
                    .font(Font.title.bold())
                
                Button("Adicionar"){
                    
                }
                
                ZStack (alignment: .bottomTrailing) {
                    Button("Continuar"){
                        showNextPage.toggle()
                    }
                    .foregroundStyle(Color.white)
                    .buttonStyle(.borderedProminent)
                    .buttonSizing(.flexible)
                    .buttonBorderShape(.capsule)
                    .padding()
                    .controlSize(.extraLarge)
                    .fullScreenCover(isPresented: $showNextPage) {
                        TabViewStruct()
                    }
                }
                
            }
            
        }
        .fullScreenCover(isPresented: $showNextPage) {
            TabViewStruct()
            
        }
        
        
    }
}


#Preview {
    OnboardingAddSubjectView()
}
