//
//  AccessibilityIdentifiers.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 26/04/2022.
//

import Foundation

public struct AccessibilityIdentifiers {
    
    public struct PostsList {
        public static let rootViewId = "\(PostsList.self).rootViewId"
        public static let tableViewId = "\(PostsList.self).tableViewId"
        public static let refreshButtonId = "\(PostsList.self).refreshButtonId"
        public static let cellId = "\(PostsList.self).cellId"
    }
    
    public struct PostDetails {
        public static let rootViewId = "\(PostsList.self).rootViewId"
        public static let titleLabelId = "\(PostsList.self).titleLabelId"
        public static let bodyLabelId = "\(PostDetails.self).bodyLabelId"
        public static let userTitleLabelId = "\(PostDetails.self).userTitleLabelId"
        public static let userNameLabelId = "\(PostDetails.self).userNameLabelId"
        public static let userEmailLabelId = "\(PostDetails.self).userEmailLabelId"
        public static let companyNameLabelId = "\(PostDetails.self).companyNameLabelId"
        public static let addressStreetLabelId = "\(PostDetails.self).addressStreetLabelId"
        public static let stackViewId = "\(PostDetails.self).stackViewId"
        public static let scrollViewId = "\(PostDetails.self).scrollViewId"
    }
}
