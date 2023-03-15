//
//  DataProviderProtocol.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 13/03/2023.
//

import Foundation

protocol DataProviderProtocol {
    var reachability: Reachable {get set}
    func getOnlineDataProvider() -> DataProviderType
    func getOfflineDataProvider() -> (posts: PostsRepository&LocalPostsRepository, users: UsersRepository&LocalUsersRepository)
    func getDataProvider() -> DataProviderType
}
