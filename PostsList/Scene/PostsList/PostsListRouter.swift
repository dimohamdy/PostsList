//
//  PostsListRouter.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import Foundation

class PostsListRouter {
    weak var viewController: PostsListViewController?

    func navigateToPostDetails(post: Post) {
        let dataProviderType = DataProvider.getDataProvider()
        let addPostViewController = PostDetailsBuilder.viewController(post: post, dataProviderType: dataProviderType)
        viewController?.navigationController?.pushViewController(addPostViewController, animated: true)
    }

}
