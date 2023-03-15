//
//  WebUsersRepository.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation

final class WebUsersRepository: UsersRepository {

    let client: APIClient

    init(client: APIClient = APIClient()) {
        self.client = client
    }

    func getUsers() async throws -> [User] {
        guard let path = APILinksFactory.API.users.path,
              let url = URL(string: path) else {
            throw PostsListError.wrongURL
        }
        // return the value from try direct without set it in another value
        let users: Users = try await client.loadData(from: url)
        return users
    }

    func getUser(by userID: Int) async throws -> User? {
        guard let path = APILinksFactory.API.user(userID: userID).path,
              let url = URL(string: path) else {
            throw PostsListError.wrongURL
        }
        // return the value from try direct without set it in another value
        let user: User? = try? await client.loadData(from: url)
        return user
    }

}
