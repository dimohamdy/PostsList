//
//  Company+CoreDataClass.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

@objc(CompanyDAO)
public class CompanyDAO: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyDAO> {
        return NSFetchRequest<CompanyDAO>(entityName: "CompanyDAO")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String?

    func toModel() -> Company {
        Company(bs: bs, catchPhrase: catchPhrase, name: name)
    }
}
