//
//  PostsListViewControllerTests.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 06/10/2022.
//

import Foundation
import SnapshotTesting
@testable import PostsList
import XCTest
import Network

final class PostsListViewControllerTests: XCTestCase {
    var postsListViewController: PostsListViewController!

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        postsListViewController = nil
    }

    func test_snapshot_noInternet_NoOfflinePosts() {
        let expectation = XCTestExpectation()

        CoreDataManager.shared.deletePosts()
        let connectToInternet = MockReachability(internetConnectionState: .unsatisfied)
        postsListViewController = PostsListBuilder.viewController(dataProvider: MockNoDataProvider(reachability: connectToInternet), reachable: connectToInternet)

        // Check the datasource after getPosts result bind to TableView
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            assertSnapshot(matching: postsListViewController, as: .image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func test_snapshot_get_onlinePosts_success() {
        let expectation = XCTestExpectation()

        setVC(internetConnectionState: .satisfied)
        // Check the datasource after getPosts result bind to TableView
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in

            assertSnapshot(matching: postsListViewController, as: .image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func test_snapshot_getData_offline() {
        let expectation = XCTestExpectation()
        setVC(internetConnectionState: .unsatisfied)

        // Check the datasource after getPosts result bind to TableView
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            assertSnapshot(matching: postsListViewController, as: .image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3)
    }
}

extension PostsListViewControllerTests {

    func setVC(internetConnectionState: NWPath.Status) {
        let connectToInternet = MockReachability(internetConnectionState: internetConnectionState)
        postsListViewController = PostsListBuilder.viewController(dataProvider: MockDataProvider(reachability: connectToInternet), reachable: connectToInternet)
    }
}
