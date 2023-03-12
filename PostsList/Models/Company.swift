//
//  Comapny.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation

extension Company : Decodable {

    enum CodingKeys: String, CodingKey {
        case bs
        case catchPhrase = "catchPhrase"
        case name
    }
}
