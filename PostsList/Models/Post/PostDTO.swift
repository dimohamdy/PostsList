//
//  PostDTO.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 15/03/2023.
//

import Foundation

struct PostDTO: Decodable {

    let body: String
    let id: Int
    let title: String
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }

    func toModel() -> Post {
        Post(body: body, id: id, title: title, userId: userId, user: nil)
    }
}
