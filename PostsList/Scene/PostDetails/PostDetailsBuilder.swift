//
//  PostsListBuilder.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import UIKit

struct PostDetailsBuilder {

    static func viewController(post: Post, dataProviderType: DataProviderType) -> PostDetailsViewController {
       let logger = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: PostsListPresenter.self))
        let presenter = PostDetailsPresenter(post: post, dataProviderType: dataProviderType, logger: logger)
        let viewController: PostDetailsViewController = PostDetailsViewController(presenter: presenter)
        presenter.output = viewController
        return viewController
    }
}
