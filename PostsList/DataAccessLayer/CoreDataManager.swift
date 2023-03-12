//
//  CoreDataManager.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 11/03/2023.
//

import Foundation
import CoreData

class CoreDataManager {

    private let proxyLogger = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: CoreDataManager.self))

    static let shared = CoreDataManager()

    private init(){
        
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostsList")
        container.loadPersistentStores(completionHandler: { [weak self ](storeDescription, error) in
            if let error = error as NSError? {
                self?.proxyLogger.log("Unresolved error \(error), \(error.userInfo)", level: .error)
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                proxyLogger.log("Unresolved error \(nserror), \(nserror.userInfo)", level: .error)
            }
        }
    }

}
