//
//  Post.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

// MARK: - PostElement
extension Post: Decodable {

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
        case title
        case body
    }
}

typealias Posts = [Post]
/*
extension Post {
    var postModel: UIPostModel {
        UIPostModel(name: name, lat: lat, long: long)
    }
}

struct UIPostModel {
    let name: String
    let lat: Double
    let long: Double

    init(name: String?, lat: Double, long: Double) {
        self.lat = lat
        self.long = long
        self.name = name ?? "\(Strings.latitude.localized()):\(lat), \(Strings.longitude.localized()):\(long)"
    }
}
*/
