//
//  PostDetailsPresenter.swift
//  PostDetails
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import Foundation

protocol PostDetailsPresenterInput: BasePresenterInput {
}

protocol PostDetailsPresenterOutput: BasePresenterOutput {
    func showPost(post: Post, user: User)
    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType)
}

final class PostDetailsPresenter {
    
    // MARK: Injections
    weak var output: PostDetailsPresenterOutput?
    
    private var postDetailsUseCase: PostDetailsUseCaseProtocol
    private var post: Post?
    
    private let logger: LoggerProtocol
    
    // MARK: Init
    init(post: Post?, postDetailsUseCase: PostDetailsUseCaseProtocol, logger: LoggerProtocol) {
        
        self.postDetailsUseCase = postDetailsUseCase
        self.post = post
        self.logger = logger
        
        [Notifications.Reachability.connected.name, Notifications.Reachability.notConnected.name].forEach { notification in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePost), name: Notifications.Data.updatePost.name, object: nil)
    }
    
    @objc
    private func changeInternetConnection(notification: Notification) {
        if notification.name == Notifications.Reachability.notConnected.name {
            DispatchQueue.main.async { [self] in
                output?.showError(title: Strings.noInternetConnectionTitle.localized(), subtitle: Strings.noInternetConnectionSubtitle.localized())
            }
        }
    }

    @objc
    private func updatePost(notification: Notification) {
        if notification.name == Notifications.Data.updatePost.name, let selectedPost = notification.userInfo?["post"] as? Post {
            self.post = selectedPost
            viewDidLoad()
        }
    }

}

// MARK: - PostDetailsPresenterInput

extension PostDetailsPresenter: PostDetailsPresenterInput {
    
    func viewDidLoad() {

        guard let  post else {
            output?.emptyState(emptyPlaceHolderType: .noPostSelected)
            return
        }
        if let user = post.user {
            output?.showPost(post: post, user: user)
        }
        
        Task {
            await getData(post: post)
        }
    }
    
    private func getData(post: Post) async {
        do {
            output?.showLoading()
            // Get data from online
            let postDetailsData: PostDetailsData  = try await postDetailsUseCase.getPostDetails(post: post)
            
            output?.hideLoading()
            
            // Get the post from the back if the post updated or if Updated from backend
            if  let postData = postDetailsData.post, let userData = postDetailsData.user {
                DispatchQueue.main.async { [self] in
                    output?.showPost(post: postData, user: userData)
                }
            }
            
        } catch let error {
            output?.showError(title: Strings.noPostDetailsErrorTitle.localized(), subtitle: Strings.noPostDetailsErrorSubtitle.localized())
        }
        
    }
}
