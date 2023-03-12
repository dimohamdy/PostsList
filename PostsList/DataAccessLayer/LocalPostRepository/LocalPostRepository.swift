//
//  LocalPostRepository.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

protocol LocalPostRepositoryUpdate: AnyObject {
    func updated(localPosts: [Post])
}

protocol LocalPostRepository: PostsRepository {
    var delegate: LocalPostRepositoryUpdate? { get set }

    func save(post: Post)
    func remove(post: Post)
}
