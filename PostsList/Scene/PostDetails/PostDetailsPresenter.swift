//
//  PostDetailsPresenter.swift
//  PostDetails
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import Foundation

protocol PostDetailsPresenterInput: BasePresenterInput {
}

protocol PostDetailsPresenterOutput: BasePresenterOutput {
    func showPost(post: Post, user: User)
}

final class PostDetailsPresenter {

    // MARK: Injections
    weak var output: PostDetailsPresenterOutput?
    var postsRepository: PostsRepository
    var usersRepository: UsersRepository
    let post: Post

    private let logger: LoggerProtocol

    // MARK: Init
    init(post: Post, dataProviderType: DataProviderType, logger: LoggerProtocol) {
        self.postsRepository = dataProviderType.posts
        self.usersRepository = dataProviderType.users
        self.post = post
        self.logger = logger
        [Notifications.Reachability.connected.name, Notifications.Reachability.notConnected.name].forEach { notification in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }
    }

    @objc
    private func changeInternetConnection(notification: Notification) {
        if notification.name == Notifications.Reachability.notConnected.name {

            DispatchQueue.main.async { [self] in
                output?.showError(title: Strings.noInternetConnectionTitle.localized(), subtitle: Strings.noInternetConnectionSubtitle.localized())
            }
        }

        let provider =  DataProvider.getDataProvider()
        postsRepository = provider.posts
        usersRepository = provider.users
    }
}

// MARK: - PostDetailsPresenterInput
extension PostDetailsPresenter: PostDetailsPresenterInput {

    func viewDidLoad() {
        if let user = post.user {
            output?.showPost(post: post, user: user)
        }

        Task {
            do {
                try await getData()
            } catch let error {
                logger.log(error.localizedDescription, level: .error)
            }
        }
    }

    func getData() async throws {
        //MARK: online Mode
        DispatchQueue.main.async { [self] in
            output?.showLoading()
        }
        // Get data from online
        let postData: Post? = try? await postsRepository.getPost(by: Int(post.id)) ?? post
        let userData: User? = try? await usersRepository.getUser(by: Int(post.userId))

        DispatchQueue.main.async { [self] in
            output?.hideLoading()
        }
        // Get the post from the back if the post updated or if Updated from backend
        if let postData, let userData {
            DispatchQueue.main.async { [self] in
              output?.showPost(post: postData, user: userData)
            }
            return
        }

        //MARK: Offline Mode
        if let userData = try? await DataProvider.getOfflineDataProvider().users.getUser(by: Int(post.userId)) {
            DispatchQueue.main.async { [self] in

                output?.showPost(post: post, user: userData)
            }
        } else {
            DispatchQueue.main.async { [self] in
                output?.showError(title: "NO data", subtitle: "No data to show")
            }
        }
    }

}
