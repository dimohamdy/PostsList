//
//  Address.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation

struct Address {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?

    func toModel() -> AddressDAO {
        let address = AddressDAO(context: CoreDataManager.shared.persistentContainer.viewContext)
        address.street = street
        address.suite = suite
        address.city = city
        address.zipcode = zipcode
        address.geo = geo?.toModel()
        return address
    }
}
