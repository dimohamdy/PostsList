//
//  Address.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation

extension Address: Decodable {

    enum CodingKeys: String, CodingKey {
        case city
        case geo
        case street
        case suite
        case zipcode
    }
}
