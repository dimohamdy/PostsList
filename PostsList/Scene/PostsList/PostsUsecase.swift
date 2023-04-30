//
//  PostsUseCase.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 26/04/2023.
//

import Foundation

typealias PostsData = (posts: Posts, isOnline: Bool)
protocol PostsUseCaseProtocol {
    func getPosts()  async throws -> PostsData
}

class PostsUseCase: PostsUseCaseProtocol {

    let postsRepository: PostsRepository
    let localPostsRepository: PostsRepository&LocalPostsRepository

    let usersRepository: UsersRepository
    let localUsersRepository: UsersRepository&LocalUsersRepository

    let reachable: Reachable

    // internal
    private let logger: LoggerProtocol

    // MARK: Init
    init(postsRepository: PostsRepository,
         localPostsRepository: PostsRepository&LocalPostsRepository,
         usersRepository: UsersRepository,
         localUsersRepository: UsersRepository&LocalUsersRepository,
         reachable: Reachable = Reachability.shared,
         logger: LoggerProtocol) {

        self.postsRepository = postsRepository
        self.localPostsRepository = localPostsRepository
        self.usersRepository = usersRepository
        self.localUsersRepository = localUsersRepository

        self.reachable = reachable

        self.logger = logger
    }

    func getPosts()  async throws -> PostsData {
        let postsSections = await reachable.isConnected ? try getPostsDataOnline() : try getPostsDataOffline()
        return postsSections
    }

    private func getPostsDataOffline()  async throws -> (posts: Posts, isOnline: Bool) {
        let postsFromDatabase = try await localPostsRepository.getPosts()

        if postsFromDatabase.isEmpty {
            throw PostsListError.noResults
        } else {
            return (posts: postsFromDatabase, isOnline: false)

        }
    }

    private func getPostsDataOnline()  async throws -> PostsData {
        do {
            guard let posts = try? await postsRepository.getPosts(), !posts.isEmpty else {
                return try await getPostsDataOffline()
            }
            // Save Posts
            localPostsRepository.deletePosts()
            try localPostsRepository.save(posts: posts)

            saveUsersDataForOfflineUsage()

            if posts.isEmpty {
                throw PostsListError.noResults
            } else {
                return (posts: posts, isOnline: true)

            }
        }
    }

    private func saveUsersDataForOfflineUsage() {
        // Get the whole data for the offline usage
        Task {
            do {
                if let users = try? await usersRepository.getUsers(), !users.isEmpty {
                    localUsersRepository.deleteUsers() // clear the data base
                    // Save users
                    try localUsersRepository.save(users: users)
                }

            } catch let error {
                logger.log(error.localizedDescription, level: .error)
            }
        }
    }

}
