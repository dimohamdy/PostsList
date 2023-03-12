//
//  TableViewSectionType.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import Foundation

enum TableViewSectionType {
    case online(posts: [Post])
    case local(posts: [Post])
}
