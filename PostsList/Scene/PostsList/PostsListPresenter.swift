//
//  PostsListPresenter.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import Foundation
import UIKit

protocol PostsListPresenterInput: BasePresenterInput {
    func open(indexPath: IndexPath)
    func getPosts()
}

protocol PostsListPresenterOutput: BasePresenterOutput {
    func updateData(error: Error)
    func updateData(tableSections: [TableViewSectionType])
    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType)
}

final class PostsListPresenter {

    // MARK: Injections
    weak var output: PostsListPresenterOutput? {
        didSet {
            getPosts()
        }
    }

    let postsUseCase: PostsUseCaseProtocol

    // internal
    private var posts: Posts = []
    private let router: PostsListRouter

    // MARK: Init
    init(postsUseCase: PostsUseCaseProtocol,
         router: PostsListRouter) {

        self.postsUseCase = postsUseCase
        self.router = router

        [Notifications.Reachability.connected.name, Notifications.Reachability.notConnected.name].forEach { notification in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }
    }
}

// MARK: - PostsListPresenterInput
extension PostsListPresenter: PostsListPresenterInput {

    func open(indexPath: IndexPath) {
        // Update the Details screen in iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            let post = posts[indexPath.row]
            let userInfo: [AnyHashable: Any]? = ["post": post]
            NotificationCenter.default.post(name: Notifications.Data.updatePost.name, object: nil, userInfo: userInfo)

        } else {
            let post = posts[indexPath.row]
            router.navigateToPostDetails(post: post)
        }
    }

    func getPosts() {
        output?.showLoading()
        Task {
            do {
                let data: PostsData = try await postsUseCase.getPosts()
                let tableSections = prepareData(data: data)
                posts = data.posts
                DispatchQueue.main.async { [self] in
                    output?.updateData(tableSections: tableSections)
                }
            } catch let error {
                DispatchQueue.main.async { [self] in
                    output?.updateData(error: error)
                }
            }
            output?.hideLoading()
        }
    }

    private func prepareData(data: PostsData) -> [TableViewSectionType] {
        var postsSections: [TableViewSectionType] = [TableViewSectionType]()
        if !data.posts.isEmpty {
            postsSections.append(data.isOnline ? .online(posts: data.posts)  : .local(posts: data.posts))
        }
        return postsSections
    }

    @objc
    private func changeInternetConnection(notification: Notification) {
        if notification.name == Notifications.Reachability.notConnected.name {
            output?.showError(title: Strings.noInternetConnectionTitle.localized(), subtitle: Strings.noInternetConnectionSubtitle.localized())
        }
    }

}
