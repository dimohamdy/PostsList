//
//  User.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation

protocol UsersRepository {

    func getUsers() async throws -> Users
    func getUser(by userID: Int) async throws -> User?
}

protocol LocalUsersRepository {

    func save(users: Users) throws
    func deleteUsers()
}
