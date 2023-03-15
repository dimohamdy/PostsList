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
        didSet{
            getPosts()
        }
    }

    let postsRepository: PostsRepository
    let localPostsRepository: PostsRepository&LocalPostsRepository

    let usersRepository: UsersRepository
    let localUsersRepository: UsersRepository&LocalUsersRepository

    private let router: PostsListRouter

    let reachable: Reachable

    // internal
    private var posts: [Post] = []

    private let logger: LoggerProtocol

    // MARK: Init
    init(postsRepository: PostsRepository,
         localPostsRepository: PostsRepository&LocalPostsRepository,
         usersRepository: UsersRepository,
         localUsersRepository: UsersRepository&LocalUsersRepository,
         router: PostsListRouter,
         reachable: Reachable = Reachability.shared,
         logger: LoggerProtocol) {

        self.postsRepository = postsRepository
        self.localPostsRepository = localPostsRepository
        self.usersRepository = usersRepository
        self.localUsersRepository = localUsersRepository

        self.router = router

        self.reachable = reachable

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

    func viewDidLoad() {
    }

    func saveUsersDataForOfflineUsage() {
        // Get the whole data for the offline usage
        Task {
            do {
                if let users = try? await usersRepository.getUsers(), !users.isEmpty {
                    localUsersRepository.deleteUsers() // clear the data base
                    // Save users
                    try localUsersRepository.saveUsers()
                }

            } catch let error {
                logger.log(error.localizedDescription, level: .error)
            }
        }
    }

    func getPosts() {
        guard reachable.isConnected else {
            getPostsDataOffline()
            return
        }

        getPostsDataOnline()
    }

    private func getPostsDataOffline() {
        Task {
            // output?.updateData(error: PostsListError.noInternetConnection)
            if let postsFromDatabase = try? await localPostsRepository.getPosts() {
                posts = postsFromDatabase
                let postsSections = prepareData(posts: posts, isOnline: false)
                DispatchQueue.main.async { [self] in
                    if postsSections.isEmpty {
                        output?.updateData(error: PostsListError.noResults)
                    } else {
                        output?.updateData(tableSections: postsSections)
                    }
                }
            }
        }
    }

    private func getPostsDataOnline() {
        output?.showLoading()
        Task {
            do {
                guard let posts = try? await postsRepository.getPosts(), !posts.isEmpty else {
                    getPostsDataOffline()
                    return
                }
                // Save Posts
                localPostsRepository.deletePosts()
                try localPostsRepository.savePosts()

                self.posts = posts
                let postsSections = prepareData(posts: posts, isOnline: true)
                DispatchQueue.main.async { [self] in

                    output?.hideLoading()

                    if postsSections.isEmpty {
                        output?.updateData(error: PostsListError.noResults)
                    } else {
                        output?.updateData(tableSections: postsSections)
                    }
                }
            } catch let error {
                DispatchQueue.main.async { [self] in
                    output?.updateData(error: error)
                }
            }
        }
    }

    @objc
    private func changeInternetConnection(notification: Notification) {
        if notification.name == Notifications.Reachability.notConnected.name {
            DispatchQueue.main.async { [self] in
                output?.showError(title: Strings.noInternetConnectionTitle.localized(), subtitle: Strings.noInternetConnectionSubtitle.localized())
                // output?.updateData(error: PostsListError.noInternetConnection)
            }
        }
    }

    func prepareData(posts: [Post], isOnline: Bool) -> [TableViewSectionType] {
        var postsSections: [TableViewSectionType] = [TableViewSectionType]()
        if !posts.isEmpty {
            postsSections.append(isOnline ? .online(posts: posts.map({ $0 }))  : .local(posts: posts.map({ $0 })))
        }
        return postsSections
    }
}
