//
//  Address+CoreDataClass.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject {
    required public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        geo = try values.decodeIfPresent(Geo.self, forKey: .geo)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        suite = try values.decodeIfPresent(String.self, forKey: .suite)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
    }
}
