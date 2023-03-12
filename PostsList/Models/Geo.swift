//
//  Geo.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation

extension Geo: Decodable {

    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
