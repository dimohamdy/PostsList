//
//  PostsListUITests.swift
//  PostsListUITests
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import XCTest

final class PostsListUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = true
    }

    func test_numberOfCells_PostsTableView() throws {
        let app = XCUIApplication()
        app.launch()

        let postsTableView = app.tables[AccessibilityIdentifiers.PostsList.tableViewId]

        // Wait for the asynchronous task to complete and for the table to finish updating
        let predicate = NSPredicate(format: "count > 0")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: postsTableView.cells)
        wait(for: [expectation], timeout: 5)

        // Get the list of cells in the table
        let cells = postsTableView.cells.allElementsBoundByIndex

        // Check that the number of cells in the list matches the expected number of cells
        XCTAssertEqual(cells.count, 100)
    }

    func test_numberOfCells_PostsTableView_Refresh() throws {
        let app = XCUIApplication()
        app.launch()

        let postsTableView = app.tables[AccessibilityIdentifiers.PostsList.tableViewId]
        let refreshButtonItem = app.navigationBars["Posts"].buttons[AccessibilityIdentifiers.PostsList.refreshButtonId]
        refreshButtonItem.tap()

        // Wait for the asynchronous task to complete and for the table to finish updating
        let predicate = NSPredicate(format: "count > 0")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: postsTableView.cells)
        wait(for: [expectation], timeout: 5)

        // Get the list of cells in the table
        let cells = postsTableView.cells.allElementsBoundByIndex

        // Check that the number of cells in the list matches the expected number of cells
        XCTAssertEqual(cells.count, 100)
    }

    func test_PostDetails() throws {

        let app = XCUIApplication()
        app.launch()

        let postsTableView = app.tables[AccessibilityIdentifiers.PostsList.tableViewId]
        let firstCell = postsTableView.cells["\(AccessibilityIdentifiers.PostsList.cellId).0"]
        firstCell.tap()

        // waiting to get the data and show it
        sleep(5)

        let titleLabel = app.staticTexts[AccessibilityIdentifiers.PostDetails.titleLabelId].label
        let bodyLabel = app.staticTexts[AccessibilityIdentifiers.PostDetails.bodyLabelId].label
        let userNameLabel = app.staticTexts[AccessibilityIdentifiers.PostDetails.userNameLabelId].label
        let userEmailLabel = app.staticTexts[AccessibilityIdentifiers.PostDetails.userEmailLabelId].label
        let companyNameLabel = app.staticTexts[AccessibilityIdentifiers.PostDetails.companyNameLabelId].label

        let title = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit".capitalized
        let body = "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto".capitalized
        let email = "Email: Sincere@april.biz"
        let username = "Username: Bret"
        let companyName = "Company: Romaguera-Crona"

        XCTAssertEqual(titleLabel, title)
        XCTAssertEqual(bodyLabel, body)
        XCTAssertEqual(userNameLabel, username)
        XCTAssertEqual(userEmailLabel, email)
        XCTAssertEqual(companyNameLabel, companyName)
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
