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

    private let router: PostsListRouter

    // internal
    private var posts: Posts = []

    private let logger: LoggerProtocol

    // MARK: Init
    init(postsUseCase: PostsUseCaseProtocol,
         router: PostsListRouter,
         logger: LoggerProtocol) {

        self.postsUseCase = postsUseCase
        self.router = router
        self.logger = logger

        [Notifications.Reachability.connected.name, Notifications.Reachability.notConnected.name].forEach { notification in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }
    }
}

// MARK: - PostsListPresenterInput
extension PostsListPresenter: PostsListPresenterInput {

    func open(indexPath: IndexPath) {
        let post = posts[indexPath.row]
        router.navigateToPostDetails(post: post)
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
            } catch let error  {
                DispatchQueue.main.async { [self] in
                    output?.updateData(error: error)
                }
            }
            DispatchQueue.main.async { [self] in
                output?.hideLoading()
            }
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
            DispatchQueue.main.async { [self] in
                output?.showError(title: Strings.noInternetConnectionTitle.localized(), subtitle: Strings.noInternetConnectionSubtitle.localized())
            }
        }
    }

}
