//
//  PostsListUITests.swift
//  PostsListUITests
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import XCTest
@testable import PostsList

final class PostsListUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    func test_numberOfCells_PostsTableView() throws {
        let app = XCUIApplication()
        app.launch()

        let expectation = XCTestExpectation()

        // Check the datasource after getPosts result bind to TableView
        let postsTableView = app.tables[AccessibilityIdentifiers.PostsList.tableViewId]

        XCTAssertEqual(postsTableView.cells.count, 100)

        let refreshButtonItem = app.navigationBars["Posts"].buttons[AccessibilityIdentifiers.PostsList.refreshButtonId]
        refreshButtonItem.tap()
        XCTAssertEqual(postsTableView.cells.count, 100)
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
