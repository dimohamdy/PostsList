//
//  Post+CoreDataProperties.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var body: String
    @NSManaged public var id: Int32
    @NSManaged public var title: String
    @NSManaged public var userId: Int32
    @NSManaged public var user: User?

}

extension Post : Identifiable {

}
