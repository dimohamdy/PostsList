//
//  User.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation
import CoreData

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}

extension User: Decodable {
    enum CodingKeys: String, CodingKey {
        case address
        case company
        case email
        case id
        case name
        case phone
        case username
        case website
    }
}

typealias Users = [User]
