//
//  Contact.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 19/01/25.
//

import Foundation
import SwiftData

@Model
class Contact {
    @Attribute(.unique) var id: UUID = UUID()
    var name: String
    var number: String
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    init(
        name: String,
        number: String
    ) {
        self.name = name
        self.number = number
    }
}
