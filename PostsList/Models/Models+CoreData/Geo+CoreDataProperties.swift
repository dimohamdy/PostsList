//
//  Geo+CoreDataProperties.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData


extension Geo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Geo> {
        return NSFetchRequest<Geo>(entityName: "Geo")
    }

    @NSManaged public var lat: String?
    @NSManaged public var lng: String?
    @NSManaged public var address: Address?

}

extension Geo : Identifiable {

}
