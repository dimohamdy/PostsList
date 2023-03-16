//
//  AddressDTO.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 15/03/2023.
//

import Foundation

struct AddressDTO: Decodable {

    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: GeoDTO?

    enum CodingKeys: String, CodingKey {
        case city
        case geo
        case street
        case suite
        case zipcode
    }

    func toModel() -> Address {
        Address(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo?.toModel())
     }
}
