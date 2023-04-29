//
//  UIViewController+PlaceHolderView.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 29/04/2023.
//

import UIKit

extension UIViewController {
    
    func showEmptyPlaceHolderView(withType type: EmptyPlaceHolderType, completion: (() -> Void)? = nil) -> EmptyPlaceHolderView {
        let emptyPlaceHolderView = EmptyPlaceHolderView(frame: view.bounds)
        emptyPlaceHolderView.translatesAutoresizingMaskIntoConstraints = false
        emptyPlaceHolderView.emptyPlaceHolderType = type
        emptyPlaceHolderView.completionBlock = completion
        emptyPlaceHolderView.alpha = 0.0
        view.addSubview(emptyPlaceHolderView)
        NSLayoutConstraint.activate([
            emptyPlaceHolderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyPlaceHolderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyPlaceHolderView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyPlaceHolderView.heightAnchor.constraint(equalToConstant: 200)
        ])
        UIView.animate(withDuration: 0.3) {
            emptyPlaceHolderView.alpha = 1.0
        }

        return emptyPlaceHolderView
    }

    func hideEmptyPlaceHolderView(_ emptyPlaceHolderView: EmptyPlaceHolderView) {
        UIView.animate(withDuration: 0.3, animations: {
            emptyPlaceHolderView.alpha = 0.0
        }) { _ in
            emptyPlaceHolderView.removeFromSuperview()
        }
    }
}
