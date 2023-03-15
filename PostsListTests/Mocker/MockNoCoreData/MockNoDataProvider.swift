//
//  MockNoDataProvider.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 15/03/2023.
//

import Foundation
@testable import PostsList

struct MockNoDataProvider: DataProviderProtocol {

    var reachability: Reachable

    init(reachability: Reachable) {
        self.reachability = reachability
    }

    func getOnlineDataProvider() -> PostsList.DataProviderType {
        return (getMockWebPostsRepository(), getMockWebUsersRepository())
    }

    func getOfflineDataProvider() -> (posts: PostsRepository&LocalPostsRepository, users: UsersRepository&LocalUsersRepository) {
        return (MockNoCoreDataPostsRepository() , MockNoCoreDataUsersRepository())
    }

    func getDataProvider() -> DataProviderType {
        if reachability.isConnected {
            return getOnlineDataProvider()
        } else {
            return getOfflineDataProvider()
        }
    }

    private func getMockWebPostsRepository() -> WebPostsRepository {
        let mockSession = URLSessionMock.createMockSession(fromJsonFile: "NoPosts", andStatusCode: 200, andError: nil)
        let mockAPIClient = APIClient(withSession: mockSession)
        return WebPostsRepository(client: mockAPIClient)
    }

    private func getMockWebUsersRepository() -> WebUsersRepository {
        let mockSession = URLSessionMock.createMockSession(fromJsonFile: "NoUsers", andStatusCode: 200, andError: nil)
        let mockAPIClient = APIClient(withSession: mockSession)
        return WebUsersRepository(client: mockAPIClient)
    }
}
