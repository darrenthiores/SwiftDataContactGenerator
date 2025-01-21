//
//  ContactListViewModel.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 21/01/25.
//

import Foundation

class ContactListViewModel: ObservableObject {
    private let dataSource: ContactLocalDataSource
    private let contactGenerator: ContactGenerator
    
    @Published var contacts: [Contact] = []
    @Published var isEditMode: Bool = false
    
    init(
        with dataSource: ContactLocalDataSource,
        andGenerator generator: ContactGenerator
    ) {
        self.dataSource = dataSource
        self.contactGenerator = generator
        
        Task { @MainActor in
            contacts = dataSource.fetchContacts()
        }
    }
    
    // Create new contact
    func didGenerateContact() {
        Task { @MainActor in
            dataSource.insert(contactGenerator.generateContact())
            contacts = dataSource.fetchContacts()
        }
    }
    
    // Delete contact
    func didDelete(at offsets: IndexSet) {
        Task { @MainActor in
            offsets.forEach { index in
                let contact = contacts[index]
                dataSource.delete(contact)
            }
            
            contacts = dataSource.fetchContacts()
        }
    }
    
    // Regenerate and update contact name
    func didEditName(on contact: Contact) {
        contact.name = contactGenerator.randomName()
        contact.updatedAt = Date()
    }
    
    // Regenerate and update contact phone number
    func didEditPhoneNumber(on contact: Contact) {
        contact.phoneNumber = contactGenerator.randomPhoneNumber()
        contact.updatedAt = Date()
    }
    
    // Toggle isEditMode
    func didToggleEditMode() {
        isEditMode.toggle()
    }
}
