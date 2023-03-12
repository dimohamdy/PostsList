//
//  UITableView+EmptyState.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import UIKit

extension UITableView {

    func setEmptyView(emptyPlaceHolderType: EmptyPlaceHolderType, completionBlock: (() -> Void)? = nil) {
        let frame = CGRect(x: center.x, y: center.y, width: bounds.size.width, height: bounds.size.height)
        let emptyPlaceHolderView = EmptyPlaceHolderView(frame: frame)
        emptyPlaceHolderView.translatesAutoresizingMaskIntoConstraints = false
        emptyPlaceHolderView.emptyPlaceHolderType = emptyPlaceHolderType
        emptyPlaceHolderView.completionBlock = completionBlock
        backgroundView = emptyPlaceHolderView
        NSLayoutConstraint.activate([
            emptyPlaceHolderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyPlaceHolderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyPlaceHolderView.widthAnchor.constraint(equalTo: widthAnchor),
            emptyPlaceHolderView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    func restore() {
        backgroundView = nil
    }
}
