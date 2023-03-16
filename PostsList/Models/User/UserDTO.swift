//
//  UserDTO.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 15/03/2023.
//

import Foundation

struct UserDTO: Decodable {
    let email: String
    let id: Int32
    let name: String
    let phone: String
    let username: String
    // Optional Values for Users
    let website: String?
    let address: AddressDTO?
    let company: CompanyDTO?
//    let post: NSSet?

    enum CodingKeys: String, CodingKey {
        case address
        case company
        case email
        case id
        case name
        case phone
        case username
        case website
    }

    func toModel() -> User {
        User(email: email, id: id, name: name, phone: phone, username: username, website: website, address: address?.toModel(), company: company?.toModel(), post: nil)
    }
}
