//
//  PostsListError.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

enum PostsListError: Error {
    case failedConnection
    case wrongURL
    case noResults
    case noInternetConnection
    case runtimeError(String)
    case parseError
    case fileNotFound
    case invalidServerResponse
    case noPost

    var localizedDescription: String {
        switch self {
        case .noResults:
            return Strings.noPostsErrorTitle.localized()
        case .noInternetConnection:
            return Strings.noInternetConnectionTitle.localized()
        default:
            return Strings.commonGeneralError.localized()
        }
    }
}
