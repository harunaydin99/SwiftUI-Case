//
//  User.swift
//  SwiftUI Case
//
//  Created by Harun AYDIN on 30.06.2025.
//

import Foundation

// MARK: - User Model
struct User: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company

    struct Address: Codable, Equatable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
    }

    struct Company: Codable, Equatable {
        let name: String
    }
}
