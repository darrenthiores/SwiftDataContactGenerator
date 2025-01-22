//
//  SwiftDataContextManager.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 20/01/25.
//

import Foundation
import SwiftData

class SwiftDataContextManager{
    // Singleton
    static let shared = SwiftDataContextManager()
    
    var container: ModelContainer?
    var context : ModelContext?
    
    private init() {
        do {
            container = try ModelContainer(for: Contact.self)
            if let container {
                context = ModelContext(container)
                prepopulateContacts()
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}

fileprivate extension SwiftDataContextManager {
    private func prepopulateContacts() {
        guard let context = context else { return }
        
        let fetchDescriptior = FetchDescriptor<Contact>()
        guard let entities = try? context.fetch(fetchDescriptior) else { return }
        
        if entities.isEmpty {
            Contact.contacts.forEach { contact in context.insert(contact) }
            try? context.save()
        }
    }
}
