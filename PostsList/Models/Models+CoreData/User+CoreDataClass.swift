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
        address = try values.decode(Address.self, forKey: .address)
        company = try values.decode(Company.self, forKey: .company)
        email = try values.decode(String.self, forKey: .email)
        id = try values.decode(Int32.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        phone = try values.decode(String.self, forKey: .phone)
        username = try values.decode(String.self, forKey: .username)
        website = try values.decode(String.self, forKey: .website)
    }
}
