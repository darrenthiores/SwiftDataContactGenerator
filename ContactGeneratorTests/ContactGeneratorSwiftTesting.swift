//
//  ContactGeneratorSwiftTesting.swift
//  ContactGeneratorTests
//
//  Created by Darren Thiores on 24/06/25.
//

import Testing
@testable import ContactGenerator

@Suite("Contact Generator Tests", .serialized)
struct ContactGeneratorSwiftTesting {
    private static let swiftDataContextManager = MockSwiftDataContextManager()
    private var localDataSource: ContactLocalDataSource!
    private var contactGenerator: ContactGenerator!
    
    @MainActor
    init() {
        let container = ContactGeneratorSwiftTesting.swiftDataContextManager.container
        let context = ContactGeneratorSwiftTesting.swiftDataContextManager.context
        
        localDataSource = ContactLocalDataSource(
            container: container,
            context: context
        )
        contactGenerator = .shared
    }
    
    @Test("Test contact generation, and insert contact into local database") @MainActor
    func testGenerateThenInsertContact() async throws {
        var currentContacts: [Contact] = []
        
        // Check if contact is empty
        currentContacts = localDataSource.fetchContacts()
        #expect(currentContacts == [])
        
        let contact = contactGenerator.generateContact()
        localDataSource.insert(contact)
        
        // Check if contact is inserted
        currentContacts = localDataSource.fetchContacts()
        #expect(currentContacts.contains(contact))
    }
    
    @Test("Test delete contact from local database") @MainActor
    func testDeleteContact() async throws {
        var currentContacts: [Contact] = []
        
        // Check if contacts is not empty
        currentContacts = localDataSource.fetchContacts()
        #expect(currentContacts.count > 0)
        
        let contact = try #require(currentContacts.first)
        localDataSource.delete(contact)
        
        // Check if contact is deleted
        currentContacts = localDataSource.fetchContacts()
        #expect(currentContacts.count == 0)
    }
}
