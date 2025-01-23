//
//  ContactGeneratorTests.swift
//  ContactGeneratorTests
//
//  Created by Darren Thiores on 22/01/25.
//

import XCTest
@testable import ContactGenerator

class ContactGeneratorTests: XCTestCase {
    private var localDataSource: ContactLocalDataSource!
    private var contactGenerator: ContactGenerator!
    
    @MainActor
    override func setUpWithError() throws {
        let swiftDataContextManager = MockSwiftDataContextManager()
        let container = swiftDataContextManager.container
        let context = swiftDataContextManager.context
        
        localDataSource = ContactLocalDataSource(
            container: container,
            context: context
        )
        contactGenerator = .shared
    }
    
    override func tearDownWithError() throws {
        localDataSource = nil
        contactGenerator = nil
    }
    
    @MainActor
    func testGenerateThenInsertContact() async {
        var currentContacts: [Contact] = []
        
        // Check if contact is empty
        currentContacts = localDataSource.fetchContacts()
        XCTAssertEqual([], currentContacts)
        
        let contact = contactGenerator.generateContact()
        localDataSource.insert(contact)
        
        // Check if contact is inserted
        currentContacts = localDataSource.fetchContacts()
        XCTAssertEqual(contact, currentContacts[0])
    }
}
