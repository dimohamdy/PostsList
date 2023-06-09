//
//  MockCoreDataUsersRepository.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 13/03/2023.
//

import Foundation
@testable import PostsList

final class MockCoreDataUsersRepository: UsersRepository, LocalUsersRepository {

    var users: Users = []
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()


    init() {
    }

    func getUsers() async throws -> Users {
        if let data = DataLoader().loadJsonData(file: "Users") {
            users = try decoder.decode([UserDTO].self, from: data).map({$0.toModel()})
            return users
        } else {
            return []
        }
    }

    func getUser(by userID: Int) async throws -> User? {
        return users.first(where: { user -> Bool in
            user.id == userID
         })
    }

    func save(users: PostsList.Users) throws {
        Task {
            try await getUsers()
        }
    }

    func deleteUsers() {
        users = []
    }
}
