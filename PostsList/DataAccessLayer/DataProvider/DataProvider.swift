//
//  DataProvider.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 12/03/2023.
//

import Foundation

typealias DataProviderType = (posts: PostsRepository, users: UsersRepository)

struct DataProvider: DataProviderProtocol {

    var reachability: Reachable

    init(reachability: Reachable = Reachability.shared) {
        self.reachability = reachability
    }

    func getOnlineDataProvider() -> DataProviderType {
        return (WebPostsRepository(), WebUsersRepository())
    }

    // TODO: Make this function cleaner
    func getOfflineDataProvider() -> (posts: PostsRepository&LocalPostsRepository, users: UsersRepository&LocalUsersRepository) {
        let viewContext = CoreDataManager.shared.viewContext
        let proxyLoggerForCoreDataPostsRepository = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: CoreDataPostsRepository.self))
        let proxyLoggerForCoreDataUsersRepository = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: CoreDataUsersRepository.self))
        return (CoreDataPostsRepository(managedObjectContext: viewContext, logger: proxyLoggerForCoreDataPostsRepository),
                CoreDataUsersRepository(managedObjectContext: viewContext, logger: proxyLoggerForCoreDataUsersRepository))
    }

    func getDataProvider() -> DataProviderType {
        if reachability.isConnected {
            return getOnlineDataProvider()
        } else {
            return getOfflineDataProvider()
        }
    }
}
