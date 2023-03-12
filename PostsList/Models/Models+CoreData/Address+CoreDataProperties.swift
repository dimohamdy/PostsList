//
//  Address+CoreDataProperties.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var city: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var geo: Geo?

}

extension Address : Identifiable {

}
