//
//  MockCoreDataUsersRepository.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 13/03/2023.
//

import Foundation
@testable import PostsList

final class MockCoreDataUsersRepository: UsersRepository, LocalUsersRepository {

    var users: [User] = []
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.persistentContainer.viewContext
        return decoder
    }()


    init() {
    }

    func getUsers() async throws -> [User] {
        if let data = DataLoader().loadJsonData(file: "Users") {
            users = try decoder.decode([User].self, from: data)
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

    func saveUsers() throws {
        Task {
            try await getUsers()
        }
    }

    func deleteUsers() {
        users = []
    }
}
