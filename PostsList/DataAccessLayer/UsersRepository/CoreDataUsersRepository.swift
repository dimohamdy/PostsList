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
        let fetchRequest: NSFetchRequest<UserDAO> = UserDAO.fetchRequest()

        do {
            // Perform Fetch Request
            let users = try managedObjectContext.fetch(fetchRequest)
            return users.map({ $0.toModel() })
        } catch {
            return []
        }
    }

    func getUser(by userID: Int) async throws -> User? {
        let fetchRequest: NSFetchRequest<UserDAO> = UserDAO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %i", userID)

        let user = try? managedObjectContext.fetch(fetchRequest).first
        return user?.toModel()
    }

    func save(users: Users) throws {
        _ = users.map({$0.toModel()})
        try managedObjectContext.save()
    }

    func deleteUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = UserDAO.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedObjectContext.execute(deleteRequest)
            try managedObjectContext.save()
        } catch let nserror as NSError {
            logger.log("Unresolved error \(nserror), \(nserror.userInfo)", level: .error)
        }
    }
}
