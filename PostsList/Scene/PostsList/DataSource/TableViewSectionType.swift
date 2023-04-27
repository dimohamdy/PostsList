//
//  TableViewSectionType.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 30/09/2022.
//

import Foundation

enum TableViewSectionType: Hashable, CaseIterable {
    static var allCases: [TableViewSectionType] { [.online(posts: []), .local(posts: [])] }

    case online(posts: Posts)
    case local(posts: Posts)
}
extension TableViewSectionType: Equatable {
    
    static func == (lhs: TableViewSectionType, rhs: TableViewSectionType) -> Bool {
        switch (lhs, rhs) {
        case (.online, .online), (.local, .local):
            return true
        default:
            return false
        }
    }
}
