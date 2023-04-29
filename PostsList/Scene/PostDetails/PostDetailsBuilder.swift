//
//  PostsListBuilder.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import UIKit

struct PostDetailsBuilder {

    static func viewController(post: Post?, dataProvider: DataProviderProtocol) -> PostDetailsViewController {
       let logger = ProxyLogger(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: PostsListPresenter.self))
        let postDetailsUseCase = PostDetailsUseCase(dataProvider: dataProvider, logger: logger)
        let presenter = PostDetailsPresenter(post: post, postDetailsUseCase: postDetailsUseCase, logger: logger)
        let viewController: PostDetailsViewController = PostDetailsViewController(presenter: presenter)
        presenter.output = viewController
        return viewController
    }
}
