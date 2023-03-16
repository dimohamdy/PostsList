//
//  Address+CoreDataClass.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

@objc(AddressDAO)
public class AddressDAO: NSManagedObject, Identifiable {

    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var city: String?
    @NSManaged public var zipcode: String?
    @NSManaged public var geo: GeoDAO?

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressDAO> {
        return NSFetchRequest<AddressDAO>(entityName: "AddressDAO")
    }

    func toModel() -> Address {
        Address(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo?.toModel())
    }
}
