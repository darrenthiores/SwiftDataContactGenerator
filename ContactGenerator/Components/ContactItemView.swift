//
//  ContactItemView.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 20/01/25.
//

import SwiftUI

struct ContactItemView: View {
    let contact: Contact
    let isEditMode: Bool
    let onEditName: () -> Void
    let onEditPhoneNumber: () -> Void
    
    private var itemSpacing: CGFloat {
        isEditMode ? 16 : 8
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: itemSpacing) {
            EditableTextView(
                title: "name",
                text: contact.name,
                isEditMode: isEditMode,
                onEdit: onEditName,
                textFont: .headline
            )
            
            EditableTextView(
                title: "phone number",
                text: contact.phoneNumber,
                isEditMode: isEditMode,
                onEdit: onEditPhoneNumber,
                textFont: .subheadline
            )
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
    
    private struct EditableTextView: View {
        let title: String
        let text: String
        let isEditMode: Bool
        let onEdit: () -> Void
        let textFont: Font
        
        var body: some View {
            if isEditMode {
                VStack(alignment: .leading, spacing: 8) {
                    Text(title.uppercased())
                        .font(.footnote)
                        .foregroundStyle(.gray)
                    
                    HStack(alignment: .center) {
                        TextField("", text: .constant(text))
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                        
                        Button {
                            onEdit()
                        } label: {
                            Image(systemName: "pencil.circle.fill")
                        }
                        .foregroundStyle(.blue)
                    }
                }
            }
            else {
                Text(text)
                    .font(textFont)
            }
        }
    }
}

#Preview {
    ContactItemView(
        contact: Contact.contacts[0],
        isEditMode: false,
        onEditName: { },
        onEditPhoneNumber: { }
    )
}
