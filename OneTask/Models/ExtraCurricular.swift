//
//  ExtraCurricular.swift
//  direcionaai
//
//  Created by Gabriel Azevedo Amorim Vieira Belo on 02/07/26.
//

import Foundation
import SwiftData

@Model
final class ExtracurricularActivity {
    
    @Relationship(deleteRule: .cascade, inverse: \userTask.activity)
    var tasks: [userTask] = []
    
    var name: String
    var activitySchedule: [SubjectDay]
    var activityDescription: String
    var activityColor: SubjectColor
    
    init(
        name: String,
        activitySchedule: [SubjectDay],
        activityDescription: String,
        activityColor: SubjectColor
    ) {
        self.name = name
        self.activitySchedule = activitySchedule
        self.activityDescription = activityDescription
        self.activityColor = activityColor
    }
}
