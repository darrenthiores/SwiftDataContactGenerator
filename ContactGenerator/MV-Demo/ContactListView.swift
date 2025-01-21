//
//  ContactListView.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 19/01/25.
//

import SwiftUI
import SwiftData

struct ContactListView: View {
    private let contactGenerator = ContactGenerator.shared
    @Query(sort: \Contact.updatedAt, order: .forward) private var contacts: [Contact]
    @Environment(\.modelContext) var context
    
    @State private var isEditMode: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts) { contact in
                    ContactItemView(
                        contact: contact,
                        isEditMode: isEditMode,
                        onEditName: {
                            contact.name = contactGenerator.randomName()
                            contact.updatedAt = Date()
                        },
                        onEditPhoneNumber: {
                            contact.phoneNumber = contactGenerator.randomPhoneNumber()
                            contact.updatedAt = Date()
                        }
                    )
                }
                .onDelete(perform: onDelete)
                .buttonStyle(.plain)
            }
            .navigationTitle("Generated Contacts")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isEditMode.toggle()
                    } label: {
                        Text("Edit")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        generateAndInsertContact()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
    
    private func onDelete(at offsets: IndexSet) {
        offsets.forEach { index in
            let contact = contacts[index]
            context.delete(contact)
        }
    }
    
    private func generateAndInsertContact() {
        let generatedContact = contactGenerator.generateContact()
        context.insert(generatedContact)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Contact.self, configurations: config)
    
    return ContactListView()
        .modelContainer(container)
}
