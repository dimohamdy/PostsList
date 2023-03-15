//
//  WebPostsRepository.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

final class WebPostsRepository: PostsRepository {

    let client: APIClient

    init(client: APIClient = APIClient()) {
        self.client = client
    }

    func getPosts() async throws -> Posts {
        guard let path = APILinksFactory.API.posts.path,
              let url = URL(string: path) else {
            throw PostsListError.wrongURL
        }
        // return the value from try direct without set it in another value  
        let posts: Posts = try await client.loadData(from: url)
        return posts
    }

    func getPost(by postID: Int) async throws -> Post? {
        guard let path = APILinksFactory.API.post(postID: postID).path,
              let url = URL(string: path) else {
            throw PostsListError.wrongURL
        }
        // return the value from try direct without set it in another value
        let post: Post? = try? await client.loadData(from: url)
        return post
    }

}
