//
//  EntryPoint.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import UIKit

struct EntryPoint {

    func initSplashScreen(window: UIWindow) {
        window.rootViewController = UINavigationController(rootViewController: PostsListBuilder.viewController())
        window.makeKeyAndVisible()
    }
}
