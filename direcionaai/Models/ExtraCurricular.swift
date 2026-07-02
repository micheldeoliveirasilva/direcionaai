//
//  ExtraCurricular.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 02/07/26.
//

import Foundation
import SwiftData

@Model
class ExtracurricularActivity {
    
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var subjectSchedule: [subjectDay]

    var activityDescription: String
    
    init(
        name: String,
        subjectSchedule: [subjectDay],
        activityDescription: String
    ) {
        self.name = name
        self.subjectSchedule = subjectSchedule
        self.activityDescription = activityDescription
    }
}
