//
//  Comapny.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 10/03/2023.
//

import Foundation

struct Company {
    let bs: String?
    let catchPhrase: String?
    let name: String?

    func toModel() -> CompanyDAO {
        let company = CompanyDAO(context: CoreDataManager.shared.persistentContainer.viewContext)
        company.bs = bs
        company.catchPhrase = catchPhrase
        company.name = name
        return company
    }
}
