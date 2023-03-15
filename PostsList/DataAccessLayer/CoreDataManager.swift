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

    private let proxyLogger = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: CoreDataManager.self))

    static let shared = CoreDataManager()

    private init() {

    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostsList")
        container.loadPersistentStores(completionHandler: { [weak self ](_, error) in
            if let error = error as NSError? {
                self?.proxyLogger.log("Unresolved error \(error), \(error.userInfo)", level: .error)
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
                    proxyLogger.log("Unresolved error \(nserror), \(nserror.userInfo)", level: .error)
                }
            }
        }
    }

    func reset() {
        let stores = persistentContainer.persistentStoreCoordinator.persistentStores
        guard !stores.isEmpty else {
            fatalError("No store found")
        }
        stores.forEach { store in
            guard let url = store.url else { fatalError("No store URL found")}

            try! FileManager.default.removeItem(at: url)
            NSPersistentStoreCoordinator.destroyStoreAtURL(url: url)
        }
    }
}

extension NSPersistentStoreCoordinator {
    public static func destroyStoreAtURL(url: URL) {
        do {
            let psc = self.init(managedObjectModel: NSManagedObjectModel())
            try psc.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
        } catch let e {
            print("failed to destroy persistent store at \(url)", e)
        }
    }
}
