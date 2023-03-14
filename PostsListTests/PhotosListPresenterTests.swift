//
//  PostsListPresenterTests.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 06/10/2022.
//

@testable import PostsList
import XCTest

/*
final class PostsListPresenterTests: XCTestCase {
    var mockPostsListPresenterOutput: MockPostsListPresenterOutput!
    private var userDefaults: UserDefaults!
    private var reachability: Reachable!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)

        mockPostsListPresenterOutput = MockPostsListPresenterOutput()
    }

    override func tearDown() {
        mockPostsListPresenterOutput = nil
        reachability = MockReachability(internetConnectionState: .satisfied)
    }

    func test_getPosts_success() {
        let expectation = XCTestExpectation()

        let presenter = getPostsListPresenter(fromJsonFile: "data")
        presenter.getPost()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            XCTAssertEqual(mockPostsListPresenterOutput.tableSections.count, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func test_getPosts_noResult() {
        let expectation = XCTestExpectation()

        let presenter = getPostsListPresenter(fromJsonFile: "noData")
        presenter.getPost()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            XCTAssertEqual(mockPostsListPresenterOutput.tableSections.count, 0)
            if let error = mockPostsListPresenterOutput.error as? PostsListError {
                switch error {
                case .noResults:
                    XCTAssertTrue(true)
                default:
                    XCTFail("the error isn't noResults")
                }
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }

    func test_getPosts_noInternetConnection() {
        reachability = MockReachability(internetConnectionState: .unsatisfied)
        let presenter = getPostsListPresenter(fromJsonFile: "noData")
        presenter.getPost()
        XCTAssertEqual(mockPostsListPresenterOutput.tableSections.count, 0)
        if let error = mockPostsListPresenterOutput.error as? PostsListError {
            switch error {
            case .noInternetConnection:
                XCTAssertTrue(true)
            default:
                XCTFail("the error isn't noResults")
            }
        }
    }

    private func getMockWebPostsRepository(mockSession: URLSessionMock) -> WebPostsRepository {
        let mockAPIClient = APIClient(withSession: mockSession)
        return WebPostsRepository(client: mockAPIClient)
    }

    private func getPostsListPresenter(fromJsonFile file: String) -> PostsListPresenter {
        let mockSession = URLSessionMock.createMockSession(fromJsonFile: file, andStatusCode: 200, andError: nil)
        let repository = getMockWebPostsRepository(mockSession: mockSession)
        let localPostRepository = UserDefaultLocalPostRepository(userDefaults: userDefaults)
        let presenter = PostsListPresenter(postsRepository: repository,
                                      localPostRepository: localPostRepository)
        presenter.output = mockPostsListPresenterOutput
        return presenter
    }
}

final class MockPostsListPresenterOutput: UIViewController, PostsListPresenterOutput {
    func emptyState(emptyPlaceHolderType: EmptyPlaceHolderType) {

    }

    var tableSections: [TableViewSectionType] = []
    var error: Error!

    func updateData(error: Error) {
        self.error = error
    }

    func updateData(tableSections: [TableViewSectionType]) {
        self.tableSections = tableSections
    }
}
*/
