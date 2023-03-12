//
//  DataProvider.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 12/03/2023.
//

import Foundation

typealias DataProviderType = (posts: PostsRepository, users: UsersRepository)

struct DataProvider {

    static func getOnlineDataProvider() -> DataProviderType {
        return (WebPostsRepository(), WebUsersRepository())
    }

    static func getOfflineDataProvider() -> (posts: PostsRepository&LocalPostsRepository, users: UsersRepository&LocalUsersRepository) {
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        return (CoreDataPostsRepository(managedObjectContext: viewContext) , CoreDataUsersRepository(managedObjectContext: viewContext))
    }

    static func getDataProvider() -> DataProviderType {
        if Reachability.shared.isConnected {
            return getOnlineDataProvider()
        } else {
            return getOfflineDataProvider()
        }
    }
}
