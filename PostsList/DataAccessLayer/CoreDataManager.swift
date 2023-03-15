//
//  CoreDataManager.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 11/03/2023.
//

import Foundation
import CoreData

protocol LocalDataProtocol {
    func saveContext ()
    func reset()
}

class CoreDataManager: LocalDataProtocol {

    private let logger = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: CoreDataManager.self))

    static let shared = CoreDataManager()

    private init() {

    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostsList")
        container.loadPersistentStores(completionHandler: { [weak self ](_, error) in
            if let error = error as NSError? {
                self?.logger.log("Unresolved error \(error), \(error.userInfo)", level: .error)
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    lazy var viewContext =  persistentContainer.viewContext

    func saveContext () {
        let context = viewContext
        Task {
            if context.hasChanges {
                do {

                    try await context.perform {
                        try context.save()
                    }
                } catch {
                    let nserror = error as NSError
                    logger.log("Unresolved error \(nserror), \(nserror.userInfo)", level: .error)
                }
            }
        }
    }

    func reset() {
        deletePosts()
        deleteUsers()
    }

    func deletePosts() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Post.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch let nserror as NSError {
            logger.log("Unresolved error \(nserror), \(nserror.userInfo)", level: .error)
        }
    }

    func deleteUsers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch let nserror as NSError {
            logger.log("Unresolved error \(nserror), \(nserror.userInfo)", level: .error)
        }
    }
}
