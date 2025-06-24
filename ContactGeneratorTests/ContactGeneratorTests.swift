//
//  ContactGeneratorTests.swift
//  ContactGeneratorTests
//
//  Created by Darren Thiores on 22/01/25.
//

import XCTest
@testable import ContactGenerator

class ContactGeneratorTests: XCTestCase {
    private static var localDataSource: ContactLocalDataSource!
    private static var contactGenerator: ContactGenerator!
    
    @MainActor
    override class func setUp() {
        let swiftDataContextManager = MockSwiftDataContextManager()
        let container = swiftDataContextManager.container
        let context = swiftDataContextManager.context
        
        localDataSource = ContactLocalDataSource(
            container: container,
            context: context
        )
        contactGenerator = .shared
    }
    
    override class func tearDown() {
        localDataSource = nil
        contactGenerator = nil
    }
    
    @MainActor
    func test1GenerateThenInsertContact() async {
        var currentContacts: [Contact] = []
        
        // Check if contact is empty
        currentContacts = ContactGeneratorTests.localDataSource.fetchContacts()
        XCTAssertEqual([], currentContacts)
        
        let contact = ContactGeneratorTests.contactGenerator.generateContact()
        ContactGeneratorTests.localDataSource.insert(contact)
        
        // Check if contact is inserted
        currentContacts = ContactGeneratorTests.localDataSource.fetchContacts()
        XCTAssertEqual(contact, currentContacts[0])
    }
    
    @MainActor
    func test2DeleteContact() async throws {
        var currentContacts: [Contact] = []
        
        // Check if contacts is not empty
        currentContacts = ContactGeneratorTests.localDataSource.fetchContacts()
        XCTAssertGreaterThan(currentContacts.count, 0)
        
        let contact = try XCTUnwrap(currentContacts.first)
        ContactGeneratorTests.localDataSource.delete(contact)
        
        // Check if contact is deleted
        currentContacts = ContactGeneratorTests.localDataSource.fetchContacts()
        XCTAssertEqual(0, currentContacts.count)
    }
}
