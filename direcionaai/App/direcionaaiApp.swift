//
//  direcionaaiApp.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 25/06/26.
//

import SwiftUI
import SwiftData

@main
struct direcionaaiApp: App {
    
    @AppStorage("completeLauch") var completeLaunch: Bool = false

    var body: some Scene {
        WindowGroup {
            
            if completeLaunch {
                TabViewStruct()
            } else {
                OnboardingView(completeLaunch: $completeLaunch)
            }
        }
        .modelContainer(for: [Subject.self, UserTask.self, ExtracurricularActivity.self])
    }
}
