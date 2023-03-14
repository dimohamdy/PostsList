//
//  WebUsersRepositoryTests.swift
//  UsersListTests
//
//  Created by Dimo Abdelaziz on 06/10/2022.
//

@testable import PostsList
import XCTest

final class WebUsersRepositoryTests: XCTestCase {
    var webUsersRepository: WebUsersRepository!

    override func tearDown() {
        webUsersRepository = nil
    }

    func test_GetItems_FromAPI() throws {
        runAsyncTest {
            let mockSession = URLSessionMock.createMockSession(fromJsonFile: "Users", andStatusCode: 200, andError: nil)
            let mockAPIClient = APIClient(withSession: mockSession)
            self.webUsersRepository = WebUsersRepository(client: mockAPIClient)
            // Act: get data from API .
            let users = try await self.webUsersRepository.getUsers()
            // Assert: Verify it's have a data.
            XCTAssertGreaterThan(users.count, 0)
            XCTAssertEqual(users.count, 10)
        }
    }

    func test_NoResult_FromAPI() {
        runAsyncTest { [self] in
            let mockSession = URLSessionMock.createMockSession(fromJsonFile: "NoUsers", andStatusCode: 200, andError: nil)
            let mockAPIClient = APIClient(withSession: mockSession)
            webUsersRepository = WebUsersRepository(client: mockAPIClient)
            // Act: get data from API .
            let users = try await webUsersRepository.getUsers()
            XCTAssertEqual(users.count, 0)
        }
    }
}

