//
//  MockSwiftDataContextManager.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 23/01/25.
//

import Foundation
import SwiftData
@testable import ContactGenerator

final class MockSwiftDataContextManager {
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            container = try ModelContainer(for: Contact.self, configurations: configuration)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
