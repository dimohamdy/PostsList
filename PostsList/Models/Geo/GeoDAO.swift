//
//  Geo+CoreDataClass.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

@objc(GeoDAO)
public class GeoDAO: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<GeoDAO> {
        return NSFetchRequest<GeoDAO>(entityName: "GeoDAO")
    }

    @NSManaged public var lat: String
    @NSManaged public var lng: String
    @NSManaged public var address: AddressDAO?

    func toModel() -> Geo {
        Geo(lat: lat, lng: lng)
    }
}
