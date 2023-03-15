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

    func getOfflineDataProvider() -> (posts: PostsRepository&LocalPostsRepository, users: UsersRepository&LocalUsersRepository) {
        let viewContext = CoreDataManager.shared.viewContext
        let proxyLoggerForCoreDataPostsRepository = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: CoreDataPostsRepository.self))
        let proxyLoggerForCoreDataUsersRepository = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: CoreDataUsersRepository.self))
        let coreDataPostsRepository = CoreDataPostsRepository(managedObjectContext: viewContext, logger: proxyLoggerForCoreDataPostsRepository)
        let coreDataUsersRepository = CoreDataUsersRepository(managedObjectContext: viewContext, logger: proxyLoggerForCoreDataUsersRepository)
        return (coreDataPostsRepository, coreDataUsersRepository)
    }

    func getDataProvider() -> DataProviderType {
        if reachability.isConnected {
            return getOnlineDataProvider()
        } else {
            return getOfflineDataProvider()
        }
    }
}
