//
//  User+CoreDataClass.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

@objc(UserDAO)
public class UserDAO: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDAO> {
        return NSFetchRequest<UserDAO>(entityName: "UserDAO")
    }

    @NSManaged public var email: String
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var username: String
    // Optional Values for Users
    @NSManaged public var website: String?
    @NSManaged public var address: AddressDAO?
    @NSManaged public var company: CompanyDAO?
    @NSManaged public var post: NSSet?

    func toModel() -> User {
        User(email: email, id: id, name: name, phone: phone, username: username, website: website, address: address?.toModel(), company: company?.toModel(), post: post)
    }
}

// MARK: Generated accessors for post
extension UserDAO {

    @objc(addPostObject:)
    @NSManaged public func addToPost(_ value: PostDAO)

    @objc(removePostObject:)
    @NSManaged public func removeFromPost(_ value: PostDAO)

    @objc(addPost:)
    @NSManaged public func addToPost(_ values: NSSet)

    @objc(removePost:)
    @NSManaged public func removeFromPost(_ values: NSSet)

}
