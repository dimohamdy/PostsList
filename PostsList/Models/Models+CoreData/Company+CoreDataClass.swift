//
//  Company+CoreDataClass.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

@objc(Company)
public class Company: NSManagedObject {
    required public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bs = try values.decodeIfPresent(String.self, forKey: .bs)
        catchPhrase = try values.decodeIfPresent(String.self, forKey: .catchPhrase)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
