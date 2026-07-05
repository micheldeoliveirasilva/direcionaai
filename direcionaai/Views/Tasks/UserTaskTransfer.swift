//
//  UserTaskTransfer.swift
//  direcionaai
//
//  Created by Michel de Oliveira Silva on 03/07/26.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers
import SwiftData

struct UserTaskTransfer: Codable, Transferable {
    
    let id: UUID
    
    static var transferRepresentation: some TransferRepresentation {
        
        CodableRepresentation(contentType: .UserTask)
        
    }
}

extension UTType {
    static let UserTask = UTType(importedAs: "com.direcionaai.task")
}
