//
//  EntryPoint.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import UIKit

struct EntryPoint {

    func initSplashScreen(window: UIWindow) {

        if UIDevice.current.userInterfaceIdiom == .pad {
            let splitVC = UISplitViewController()
            splitVC.preferredDisplayMode = .oneBesideSecondary
            let postsListViewController = PostsListBuilder.viewController()
            let postDetailsViewController = PostDetailsBuilder.viewController(post: nil, dataProvider: DataProvider())
            splitVC.viewControllers = [UINavigationController(rootViewController: postsListViewController),
                                       UINavigationController(rootViewController: postDetailsViewController)]
            window.rootViewController = splitVC
            window.makeKeyAndVisible()
        } else {
            window.rootViewController = UINavigationController(rootViewController: PostsListBuilder.viewController())
            window.makeKeyAndVisible()
        }
    }
}
