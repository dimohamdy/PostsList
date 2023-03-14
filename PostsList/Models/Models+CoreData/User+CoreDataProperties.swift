//
//  User+CoreDataProperties.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var username: String
    // Optional Values for Users
    @NSManaged public var website: String?
    @NSManaged public var address: Address?
    @NSManaged public var company: Company?
    @NSManaged public var post: NSSet?

}

// MARK: Generated accessors for post
extension User {

    @objc(addPostObject:)
    @NSManaged public func addToPost(_ value: Post)

    @objc(removePostObject:)
    @NSManaged public func removeFromPost(_ value: Post)

    @objc(addPost:)
    @NSManaged public func addToPost(_ values: NSSet)

    @objc(removePost:)
    @NSManaged public func removeFromPost(_ values: NSSet)

}

extension User : Identifiable {

}
