//
//  GeoDTO.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 15/03/2023.
//

import Foundation

struct GeoDTO: Decodable {

    let lat: String
    let lng: String

    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }

    func toModel() -> Geo {
        Geo(lat: lat, lng: lng)
     }

}
