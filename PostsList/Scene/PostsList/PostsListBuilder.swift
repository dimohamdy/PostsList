//
//  PostsListBuilder.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import UIKit

struct PostsListBuilder {

    static func viewController(dataProvider: DataProviderProtocol = DataProvider(), reachable: Reachable = Reachability.shared) -> PostsListViewController {
        let logger = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: PostsListPresenter.self))

        let onlineProvider = dataProvider.getOnlineDataProvider()
        let offlineProvider = dataProvider.getOfflineDataProvider()
        let router = PostsListRouter()
        let postsUseCase = PostsUseCase(postsRepository: onlineProvider.posts,
             localPostsRepository: offlineProvider.posts,
             usersRepository: onlineProvider.users,
             localUsersRepository: offlineProvider.users,
             reachable: reachable,
             logger: logger)

        let presenter = PostsListPresenter(postsUseCase: postsUseCase,
                                           router: router)
        let viewController: PostsListViewController = PostsListViewController(presenter: presenter)
        presenter.output = viewController

        router.viewController = viewController

        return viewController
    }
}
