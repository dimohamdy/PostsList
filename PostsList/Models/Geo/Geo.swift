//
//  Geo.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation

struct Geo {
    let lat: String
    let lng: String

    func toModel() -> GeoDAO {
        let geo = GeoDAO(context: CoreDataManager.shared.persistentContainer.viewContext)
        geo.lat = lat
        geo.lng = lng
        return geo
    }
}
