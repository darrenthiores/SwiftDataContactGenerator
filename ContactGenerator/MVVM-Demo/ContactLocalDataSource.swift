//
//  ContactLocalDataSource.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 21/01/25.
//

import Foundation
import SwiftData

@MainActor
class ContactLocalDataSource {
    private let container: ModelContainer?
    private let context: ModelContext?
    
    init(container: ModelContainer?, context: ModelContext?) {
        self.container = container
        self.context = context
    }
}

extension ContactLocalDataSource {
    func insert(_ entity: Contact) {
        self.container?.mainContext.insert(entity)
        try? self.container?.mainContext.save()
    }
    
    func delete(_ entity: Contact) {
        self.container?.mainContext.delete(entity)
        try? self.container?.mainContext.save()
    }
    
    func fetchContacts() -> [Contact] {
        let fetchDescriptor = FetchDescriptor<Contact>(sortBy: [SortDescriptor(\.updatedAt, order: .forward)])
        let contacts = try? self.container?.mainContext.fetch(fetchDescriptor)
        return contacts ?? []
    }
}
