//
//  CoreDataUsersRepository.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 11/03/2023.
//

import Foundation
import CoreData

final class CoreDataUsersRepository: UsersRepository, LocalUsersRepository {

    let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func getUsers() async throws -> [User] {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            // Perform Fetch Request
            let users = try managedObjectContext.fetch(fetchRequest)
            return users
        } catch {
            return []
        }
    }

    func getUser(by userID: Int) async throws -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        fetchRequest.fetchLimit = 1

        fetchRequest.predicate = NSPredicate(format: "id = %i", userID)

        // Fetch a single object. If the object does not exist,
        // nil is returned
        let user = try? managedObjectContext.fetch(fetchRequest).first

        return user
    }

    func saveUsers() throws {
        try managedObjectContext.save()
    }
}
