//
//  UITableView+ReusableCell.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<T: CellReusable>(for indexPath: IndexPath) -> T? {
        self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T
    }
}
