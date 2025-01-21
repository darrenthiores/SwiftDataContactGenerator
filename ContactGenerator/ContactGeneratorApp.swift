//
//  ContactGeneratorApp.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 19/01/25.
//

import SwiftUI

@main
struct ContactGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            MVVMContactListView()
        }
        // .modelContainer(for: [Contact.self])
    }
}
