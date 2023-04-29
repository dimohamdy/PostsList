//
//  PostsListRouter.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import Foundation

class PostsListRouter {
    weak var viewController: PostsListViewController?

    func navigateToPostDetails(dataProvider: DataProviderProtocol = DataProvider(), post: Post) {
        let postDetailsViewController = PostDetailsBuilder.viewController(post: post, dataProvider: dataProvider)
        viewController?.navigationController?.pushViewController(postDetailsViewController, animated: true)
    }
}
