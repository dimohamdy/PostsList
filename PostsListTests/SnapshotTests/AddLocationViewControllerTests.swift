//
//  AddPostViewControllerTests.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 06/10/2022.
//

import Foundation
import SnapshotTesting
@testable import PostsList
import XCTest
/*
final class AddPostViewControllerTests: XCTestCase {
    var addPostViewController: AddPostViewController!
    var navigationController: UINavigationController!

    var localPostRepository: UserDefaultLocalPostRepository!
    private var userDefaults: UserDefaults!

    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        localPostRepository = UserDefaultLocalPostRepository(userDefaults: userDefaults)
    }

    override func tearDown() {
        addPostViewController = nil
        _ = localPostRepository.clearPosts()
    }

    func test_snapshot_fill_addPost_form() {
        let expectation = XCTestExpectation()
        setVC(localPostRepository: localPostRepository)

        if let postNameTextField = getTextField(tag: AddPostViewController.Tags.postNameTextField) {
            postNameTextField.text = "Cairo"
        }

        if let latitudeTextField = getTextField(tag: AddPostViewController.Tags.latitudeTextField) {
            latitudeTextField.text = "12.3333"

        }

        if let longitudeTextField = getTextField(tag: AddPostViewController.Tags.longitudeTextField) {
            longitudeTextField.text = "34.44444"
        }

        assertSnapshot(matching: navigationController, as: .image)
    }

    func test_snapshot_fill_addPost_form_error() {
        let expectation = XCTestExpectation()
        setVC(localPostRepository: localPostRepository)

        if let postNameTextField = getTextField(tag: AddPostViewController.Tags.postNameTextField) {
            postNameTextField.text = "Cairo"
        }

        if let latitudeTextField = getTextField(tag: AddPostViewController.Tags.latitudeTextField) {
            latitudeTextField.text = "123333"

        }

        if let longitudeTextField = getTextField(tag: AddPostViewController.Tags.longitudeTextField) {
            longitudeTextField.text = "3444444"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in

            assertSnapshot(matching: navigationController, as: .image)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 6)
    }



//    func test_snapshot_getData_online() {
//        let expectation = XCTestExpectation()
//
//        let presenter = AddPostPresenter(localPostRepository: localPostRepository)
//        setVC(presenter: presenter)
//        presenter.getPost()
//
//        // Check the datasource after getPosts result bind to TableView
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
//            assertSnapshot(matching: addPostViewController, as: .image)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 3)
//
//    }
}

extension AddPostViewControllerTests {

    func getTextField(tag: AddPostViewController.Tags) -> UITextField? {
        return addPostViewController.view.viewWithTag(tag.rawValue) as? UITextField
    }

    func getSaveButtonItem() -> UIBarButtonItem? {
        return addPostViewController.navigationItem.rightBarButtonItems?.first
    }

    func setVC(localPostRepository: LocalPostRepository) {
        addPostViewController = AddPostBuilder.viewController(localPostRepository: localPostRepository)
        navigationController = UINavigationController(rootViewController: addPostViewController)
    }
}
*/
