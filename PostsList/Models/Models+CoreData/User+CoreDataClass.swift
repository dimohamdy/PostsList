//
//  User+CoreDataClass.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    required public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int32.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        website = try values.decodeIfPresent(String.self, forKey: .website)
    }
}
