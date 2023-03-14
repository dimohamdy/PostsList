//
//  WebPostsRepositoryTests.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 06/10/2022.
//

@testable import PostsList
import XCTest

final class WebPostsRepositoryTests: XCTestCase {
    var webPostsRepository: WebPostsRepository!

    override func tearDown() {
        webPostsRepository = nil
    }

    func test_GetItems_FromAPI() throws {
        runAsyncTest {
            let mockSession = URLSessionMock.createMockSession(fromJsonFile: "Posts", andStatusCode: 200, andError: nil)
            let mockAPIClient = APIClient(withSession: mockSession)
            self.webPostsRepository = WebPostsRepository(client: mockAPIClient)
            // Act: get data from API .
            let posts = try await self.webPostsRepository.getPosts()
            // Assert: Verify it's have a data.
            XCTAssertGreaterThan(posts.count, 0)
            XCTAssertEqual(posts.count, 100)
        }
    }

    func test_NoResult_FromAPI() {
        runAsyncTest { [self] in
            let mockSession = URLSessionMock.createMockSession(fromJsonFile: "NoPosts", andStatusCode: 200, andError: nil)
            let mockAPIClient = APIClient(withSession: mockSession)
            webPostsRepository = WebPostsRepository(client: mockAPIClient)
            // Act: get data from API .
            let posts = try await webPostsRepository.getPosts()
            XCTAssertEqual(posts.count, 0)
        }
    }
}

