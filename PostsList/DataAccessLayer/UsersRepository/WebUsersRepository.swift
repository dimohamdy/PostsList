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

    func getUsers() async throws -> Users {
        guard let path = APILinksFactory.API.users.path,
              let url = URL(string: path) else {
            throw PostsListError.wrongURL
        }
        let users: [UserDTO] = try await client.loadData(from: url)
        return users.map({ $0.toModel() })
    }

    func getUser(by userID: Int) async throws -> User? {
        guard let path = APILinksFactory.API.user(userID: userID).path,
              let url = URL(string: path) else {
            throw PostsListError.wrongURL
        }
        let user: UserDTO? = try? await client.loadData(from: url)
        return user?.toModel()
    }

}
