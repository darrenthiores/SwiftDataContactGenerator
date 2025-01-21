//
//  ContactGenerator.swift
//  ContactGenerator
//
//  Created by Darren Thiores on 19/01/25.
//

import Foundation

struct ContactGenerator {
    private init() {  }
    static let shared = ContactGenerator()
    
    // Generate contact with random string and phone number
    func generateContact() -> Contact {
        return Contact(
            name: randomName(),
            phoneNumber: randomPhoneNumber()
        )
    }

    // Generate random name
    func randomName(
        withLength length: Int = 8
    ) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var name = ""
        
        (0..<length).forEach { _ in
            let randomChar = letters.randomElement()
            if let randomChar = randomChar {
                name.append(randomChar)
            }
        }
        
        return name
    }

    // Generate random phone number
    func randomPhoneNumber(
        withLength length: Int = 8
    ) -> String {
        var phoneNumber = "0"
        
        (0..<length).forEach { i in
            // Make sure phone number starts with 0 without replication
            let randomInt = i == 0 ? Int.random(in: 1...9)
            : Int.random(in: 0...9)
            
            phoneNumber += "\(randomInt)"
        }
        
        return phoneNumber
    }
}
