//
//  Strings.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation

enum Strings: String {

    // MARK: Errors
    case commonGeneralError = "Common_GeneralError"
    case commonInternetError = "Common_InternetError"

    // MARK: Post
    case postListTitle = "Post_List_Title"
    case postDetailsTitle = "Post_Details_Title"

    // MARK: Internet Errors
    case noInternetConnectionTitle = "No_Internet_Connection_Title"
    case noInternetConnectionSubtitle = "No_Internet_Connection_Subtitle"

    // MARK: Posts Errors
    case noPostsErrorTitle = "No_Posts_Error_Title"
    case noPostsErrorSubtitle = "No_Posts_Error_Subtitle"

    // MARK: TableView Headers
    case onlineTitle = "Online_Title"
    case localTitle = "Local_Title"

    case tryAction = "Try_Action"

    case latitude = "Latitude"
    case longitude = "Longitude"

    case wrongData = "Wrong_Data"

    case checkValueLatitude = "Check_Value_Latitude"

    case checkValueLongitude = "Check_Value_Longitude"

    case postAdded = "Post_Added_Successfully"

    case authorTitle = "Author_Title"
    case usernameTitle = "Username_Title"
    case emailTitle = "Email_Title"
    case addressTitle = "Address_Title"
    case companyTitle = "Company_Title"


    func localized() -> String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
