//
//  PostsListUITests.swift
//  PostsListUITests
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import XCTest

final class PostsListUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let tablesQuery = app.tables
        XCTAssertEqual(tablesQuery.tableRows.count, 100)
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Optio Molestias Id Quia Eum"]/*[[".cells.staticTexts[\"Optio Molestias Id Quia Eum\"]",".staticTexts[\"Optio Molestias Id Quia Eum\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let postsButton = app.navigationBars["Post Details"].buttons["Posts"]
        postsButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Est Et Quae Odit Qui Non"]/*[[".cells.staticTexts[\"Est Et Quae Odit Qui Non\"]",".staticTexts[\"Est Et Quae Odit Qui Non\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        postsButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Repellendus Qui Recusandae Incidunt Voluptates Tenetur Qui Omnis Exercitationem"]/*[[".cells.staticTexts[\"Repellendus Qui Recusandae Incidunt Voluptates Tenetur Qui Omnis Exercitationem\"]",".staticTexts[\"Repellendus Qui Recusandae Incidunt Voluptates Tenetur Qui Omnis Exercitationem\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Temporibus Sit Alias Delectus Eligendi Possimus Magni"]/*[[".cells.staticTexts[\"Temporibus Sit Alias Delectus Eligendi Possimus Magni\"]",".staticTexts[\"Temporibus Sit Alias Delectus Eligendi Possimus Magni\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
