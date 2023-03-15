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
    let logger: LoggerProtocol

    init(managedObjectContext: NSManagedObjectContext, logger: LoggerProtocol) {
        self.managedObjectContext = managedObjectContext
        self.logger = logger
    }

    func getUsers() async throws -> Users {
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
        fetchRequest.predicate = NSPredicate(format: "id = %i", userID)

        let user = try? managedObjectContext.fetch(fetchRequest).first
        return user
    }

    func saveUsers() throws {
        try managedObjectContext.save()
    }

    func deleteUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch let nserror as NSError {
            logger.log("Unresolved error \(nserror), \(nserror.userInfo)", level: .error)
        }
    }
}
