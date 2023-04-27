//
//  Post.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

struct Post {

    let body: String
    let id: Int
    let title: String
    let userId: Int
    let user: User?

    func toModel() -> PostDAO {
        let post = PostDAO(context: CoreDataManager.shared.persistentContainer.viewContext)
        post.body = body
        post.id = Int32(id)
        post.title = title
        post.userId = Int32(userId)
        return post
    }
}

extension Post: Hashable {
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - PostElement

typealias Posts = [Post]
