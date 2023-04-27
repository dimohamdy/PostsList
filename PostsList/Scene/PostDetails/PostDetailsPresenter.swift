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
}

final class PostDetailsPresenter {
    
    // MARK: Injections
    weak var output: PostDetailsPresenterOutput?
    
    private var postDetailsUseCase: PostDetailsUseCaseProtocol
    private let post: Post
    
    private let logger: LoggerProtocol
    
    // MARK: Init
    init(post: Post, postDetailsUseCase: PostDetailsUseCaseProtocol, logger: LoggerProtocol) {
        
        self.postDetailsUseCase = postDetailsUseCase
        self.post = post
        self.logger = logger
        [Notifications.Reachability.connected.name, Notifications.Reachability.notConnected.name].forEach { notification in
            NotificationCenter.default.addObserver(self, selector: #selector(changeInternetConnection), name: notification, object: nil)
        }
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

// MARK: - PostDetailsPresenterInput
extension PostDetailsPresenter: PostDetailsPresenterInput {
    
    func viewDidLoad() {
        if let user = post.user {
            output?.showPost(post: post, user: user)
        }
        
        Task {
            await getData()
        }
    }
    
    private func getData() async {
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
