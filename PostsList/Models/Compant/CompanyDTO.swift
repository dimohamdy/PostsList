//
//  CompanyDTO.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 15/03/2023.
//

import Foundation

struct CompanyDTO: Decodable {

    let bs: String?
    let catchPhrase: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case bs
        case catchPhrase = "catchPhrase"
        case name
    }
    func toModel() -> Company {
        return Company(bs: bs, catchPhrase: catchPhrase, name: name)
     }
}
