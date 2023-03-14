//
//  PostsRepository.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

protocol PostsRepository {

    func getPosts() async throws -> [Post]
    func getPost(by postID: Int) async throws -> Post?
}

protocol LocalPostsRepository {
    func deletePosts()
    func savePosts() throws
}
