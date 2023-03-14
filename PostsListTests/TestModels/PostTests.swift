//
//  PostTests.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 06/10/2022.
//

@testable import PostsList
import XCTest

final class PostTests: XCTestCase {

    private let post = Data("""
    {
      "userId": 1,
      "id": 1,
      "title": "post title",
      "body": "post body"
    }
    """.utf8)

    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.persistentContainer.viewContext
        return decoder
    }()

    func testDecoding_whenMissingRequiredKeys_itThrows() throws {
        try ["userId", "id"].forEach { key in
            assertThrowsKeyNotFound(key, decoding: Post.self, from: try post.json(deletingKeyPaths: key))
        }
    }

    func testDecoding_whenPostData_returnsAPostObject() throws {
       let post = try decoder.decode(Post.self, from: post)
        XCTAssertEqual(post.userId, 1)
        XCTAssertEqual(post.id, 1)
        XCTAssertEqual(post.title, "post title")
        XCTAssertEqual(post.body, "post body")
    }

    func assertThrowsKeyNotFound<T: Decodable>(_ expectedKey: String, decoding: T.Type, from data: Data, file: StaticString = #file, line: UInt = #line) {
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.persistentContainer.viewContext

        XCTAssertThrowsError(try decoder.decode(decoding, from: data), file: file, line: line) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual(expectedKey, key.stringValue, "Expected missing key '\(key.stringValue)' to equal '\(expectedKey)'.", file: file, line: line)
            } else {
                XCTFail("Expected '.keyNotFound(\(expectedKey))' but got \(error)", file: file, line: line)
            }
        }
    }
}

extension Data {
    func json(deletingKeyPaths keyPaths: String...) throws -> Data {
        let decoded = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as AnyObject

        for keyPath in keyPaths {
            decoded.setValue(nil, forKeyPath: keyPath)
        }

        return try JSONSerialization.data(withJSONObject: decoded)
    }
}
