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
    var day: String
    var startTime: Date
    var endTime: Date
    var activityDescription: String
    
    init(
        name: String,
        day: String,
        startTime: Date,
        endTime: Date,
        activityDescription: String
    ) {
        self.name = name
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.activityDescription = activityDescription
    }
}
