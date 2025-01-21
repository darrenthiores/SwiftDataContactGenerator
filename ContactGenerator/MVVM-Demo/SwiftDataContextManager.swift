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
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
