//
//  ContactInfo.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct ResponseDict: Codable {
    let results: [Person]
}

struct Person: Codable {
    let name: FullName
    let location: Locations
    let email: String
    let picture: Pictures
}

struct FullName: Codable {
    let first: String
    let last: String
    var fullName: String {
        return "\(first.capitalized) \(last.capitalized)"
    }
}
struct Locations: Codable {
    let city: String
    
}
struct Pictures: Codable {
    let large: String
    let medium: String?
}
