//
//  Post+CoreDataClass.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//
//

import Foundation
import CoreData

@objc(Post)
public class Post: NSManagedObject {
    required public convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
          throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        body = try values.decode(String.self, forKey: .body)
        id = try values.decode(Int32.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        userId = try values.decode(Int32.self, forKey: .userID)
    }
}
