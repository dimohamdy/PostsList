//
//  PostsListBuilder.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import UIKit

struct PostsListBuilder {

    static func viewController() -> PostsListViewController {
        let logger = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: PostsListPresenter.self))

        let onlineProviderOnline = DataProvider.getOnlineDataProvider()
        let offlineProviderOnline = DataProvider.getOfflineDataProvider()
        let router = PostsListRouter()

        let presenter = PostsListPresenter(postsRepository: onlineProviderOnline.posts,
                                           localPostsRepository: offlineProviderOnline.posts,
                                           usersRepository: onlineProviderOnline.users,
                                           localUsersRepository: offlineProviderOnline.users,
                                           router: router,
                                           reachable: Reachability.shared,
                                           logger: logger)
        let viewController: PostsListViewController = PostsListViewController(presenter: presenter)
        presenter.output = viewController

        router.viewController = viewController

        return viewController
    }
}
