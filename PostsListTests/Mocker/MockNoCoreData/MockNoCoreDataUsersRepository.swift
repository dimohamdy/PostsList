//
//  MockNoCoreDataUsersRepository.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 13/03/2023.
//

import Foundation
@testable import PostsList

final class MockNoCoreDataUsersRepository: UsersRepository, LocalUsersRepository {

    var users: Users = []
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.persistentContainer.viewContext
        return decoder
    }()


    init() {
    }

    func getUsers() async throws -> Users {
        if let data = DataLoader().loadJsonData(file: "NoUsers") {
            users = try decoder.decode(Users.self, from: data)
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
