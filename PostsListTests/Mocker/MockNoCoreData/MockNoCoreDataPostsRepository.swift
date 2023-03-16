//
//  MockNoCoreDataPostsRepository.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 13/03/2023.
//

import Foundation
@testable import PostsList

final class MockNoCoreDataPostsRepository: PostsRepository, LocalPostsRepository {

    var posts: Posts = []
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    init() {
    }

    func getPosts() async throws -> Posts {
        if let data = DataLoader().loadJsonData(file: "NoPosts") {
            posts = try decoder.decode([PostDTO].self, from: data).map({$0.toModel()})
            return posts
        } else {
            return []
        }
    }

    func getPost(by postID: Int) async throws -> Post? {
       return posts.first(where: { post -> Bool in
            post.id == postID
        })
    }

    func save(posts: PostsList.Posts) throws {
        Task {
            try await getPosts()
        }
    }

    func deletePosts() {
        posts = []
    }

}
