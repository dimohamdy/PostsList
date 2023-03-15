//
//  MockCoreDataPostsRepository.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 13/03/2023.
//

import Foundation
@testable import PostsList

final class MockCoreDataPostsRepository: PostsRepository, LocalPostsRepository {

    var posts: [Post] = []
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.persistentContainer.viewContext
        return decoder
    }()

    init() {
    }

    func getPosts() async throws -> [Post] {
        if let data = DataLoader().loadJsonData(file: "Posts") {
            posts = try decoder.decode([Post].self, from: data)
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

    func savePosts() throws {
        Task {
            try await getPosts()
        }
    }

    func deletePosts() {
        posts = []
    }

}
