//
//  APILinksFactory.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

struct APILinksFactory {

    private static let baseURL = "https://jsonplaceholder.typicode.com/"

    enum API {
        case posts
        case post(postID: Int)
        case users
        case user(userID: Int)

        var path: String? {
            switch self {
            case .posts:
                return APILinksFactory.baseURL + "posts"
            case .post(let postID):
                return APILinksFactory.baseURL + "posts/\(postID)"
            case .users:
                return APILinksFactory.baseURL + "users"
            case .user(let userID):
                return APILinksFactory.baseURL + "users/\(userID)"
            }
        }
    }
}
