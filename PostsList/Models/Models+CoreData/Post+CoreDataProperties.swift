//
//  Post+CoreDataProperties.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

extension PostDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostDAO> {
        return NSFetchRequest<PostDAO>(entityName: "PostDAO")
    }

    @NSManaged public var body: String
    @NSManaged public var id: Int32
    @NSManaged public var title: String
    @NSManaged public var userId: Int32
    @NSManaged public var user: UserDAO?

    func toModel() -> Post {
        Post(body: body, id: Int(id), title: title, userId: Int(userId), user: nil)
    }
}

extension PostDAO: Identifiable {

}
