//
//  MVVMContactListView.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 21/01/25.
//

import SwiftUI
import SwiftData

struct MVVMContactListView: View {
    @StateObject var viewModel = ContactListViewModel(
        with: ContactLocalDataSource(
            container: SwiftDataContextManager.shared.container,
            context: SwiftDataContextManager.shared.context
        ),
        andGenerator: .shared
    )
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.contacts) { contact in
                    ContactItemView(
                        contact: contact,
                        isEditMode: viewModel.isEditMode,
                        onEditName: {
                            viewModel.didEditName(on: contact)
                        },
                        onEditPhoneNumber: {
                            viewModel.didEditPhoneNumber(on: contact)
                        }
                    )
                }
                .onDelete { offsets in
                    viewModel.didDelete(at: offsets)
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Generated Contacts")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        viewModel.didToggleEditMode()
                    } label: {
                        Text("Edit")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.didGenerateContact()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Contact.self, configurations: config)
    
    MVVMContactListView(
        viewModel: ContactListViewModel(
            with: ContactLocalDataSource(
                container: container,
                context: ModelContext(container)
            ),
            andGenerator: .shared
        )
    )
}
