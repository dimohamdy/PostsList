//
//  Company+CoreDataProperties.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String?

}

extension Company : Identifiable {

}
