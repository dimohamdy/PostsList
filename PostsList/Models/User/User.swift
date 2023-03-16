//
//  User.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation
import CoreData

// enum DecoderConfigurationError: Error {
//  case missingManagedObjectContext
// }
//
// extension CodingUserInfoKey {
//  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
// }

 struct User {
    let email: String
     let id: Int32
     let name: String
     let phone: String
     let username: String
    // Optional Values for Users
     let website: String?
     let address: Address?
     let company: Company?
     let post: NSSet?

     func toModel() -> UserDAO {
         let user = UserDAO(context: CoreDataManager.shared.persistentContainer.viewContext)

         user.email = email
         user.id = id
         user.name = name
         user.phone = phone
         user.username = username
         // Optional Values for Users
         user.website = website
         user.address = address?.toModel()
         user.company = company?.toModel()
         user.post = post
         return user
     }
}

typealias Users = [User]
