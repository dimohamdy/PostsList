//
//  File.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 27/04/2023.
//

import Foundation
protocol PostDetailsUseCaseProtocol {
    func getPostDetails(post: Post)  async throws -> PostDetailsData
}

typealias PostDetailsData = (post: Post?, user: User?)

class PostDetailsUseCase: PostDetailsUseCaseProtocol {

    // MARK: Injections
    weak var output: PostDetailsPresenterOutput?

    private var postsRepository: PostsRepository
    private var usersRepository: UsersRepository
    private var dataProvider: DataProviderProtocol

    private let logger: LoggerProtocol

    // MARK: Init
    init(dataProvider: DataProviderProtocol, logger: LoggerProtocol) {
        self.postsRepository = dataProvider.getDataProvider().posts
        self.usersRepository = dataProvider.getDataProvider().users
        self.dataProvider = dataProvider
        self.logger = logger
        [Notifications.Reachability.connected.name, Notifications.Reachability.notConnected.name].forEach { notification in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }
    }

    @objc
    private func changeInternetConnection(notification: Notification) {
        let provider =  dataProvider.getDataProvider()
        postsRepository = provider.posts
        usersRepository = provider.users
    }
}

// MARK: - PostDetailsPresenterInput
extension PostDetailsUseCase: PostDetailsPresenterInput {

    func getPostDetails(post: Post) async throws -> PostDetailsData {
        // MARK: online Mode
        // Get data from online
        let postData: Post? = try? await postsRepository.getPost(by: Int(post.id)) ?? post
        let userData: User? = try? await usersRepository.getUser(by: Int(post.userId))

        // Get the post from the back if the post updated or if Updated from backend
        if let postData, let userData {
            return (post: postData, user: userData)
        }

        // MARK: Offline Mode
        if let userData = try? await dataProvider.getOfflineDataProvider().users.getUser(by: Int(post.userId)) {
            return (post: post, user: userData)
        } else {
            throw PostsListError.noResults
        }
    }
}
