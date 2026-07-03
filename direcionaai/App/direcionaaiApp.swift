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
    var body: some Scene {
        WindowGroup {
            TabViewStruct()
                .modelContainer(
                    for: [
                        UserTask.self,
                        Subject.self,
                        ExtracurricularActivity.self
                    ]
                )
        }
    }
}
