//
//  PostTests.swift
//  PostsListTests
//
//  Created by Dimo Abdelaziz on 06/10/2022.
//

@testable import PostsList
import XCTest

final class UserTests: XCTestCase {

    private let user = Data("""
    {
      "id": 1,
      "name": "Leanne Graham",
      "username": "Bret",
      "email": "Sincere@april.biz",
      "address": {
        "street": "Kulas Light",
        "suite": "Apt. 556",
        "city": "Gwenborough",
        "zipcode": "92998-3874",
        "geo": {
          "lat": "-37.3159",
          "lng": "81.1496"
        }
      },
      "phone": "1-770-736-8031 x56442",
      "website": "hildegard.org",
      "company": {
        "name": "Romaguera-Crona",
        "catchPhrase": "Multi-layered client-server neural-net",
        "bs": "harness real-time e-markets"
      }
    }
    """.utf8)

    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.persistentContainer.viewContext
        return decoder
    }()

    func testDecoding_whenMissingRequiredKeys_itThrows() throws {
        try ["username", "name"].forEach { key in
            assertThrowsKeyNotFound(key, decoding: User.self, from: try user.json(deletingKeyPaths: key))
        }
    }

    func testDecoding_whenPostData_returnsAPostObject() throws {
       let user = try decoder.decode(User.self, from: user)
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.name, "Leanne Graham")
        XCTAssertEqual(user.username, "Bret")
        XCTAssertEqual(user.email, "Sincere@april.biz")
    }

    func assertThrowsKeyNotFound<T: Decodable>(_ expectedKey: String, decoding: T.Type, from data: Data, file: StaticString = #file, line: UInt = #line) {
        XCTAssertThrowsError(try decoder.decode(decoding, from: data), file: file, line: line) { error in
            if case .keyNotFound(let key, _)? = error as? DecodingError {
                XCTAssertEqual(expectedKey, key.stringValue, "Expected missing key '\(key.stringValue)' to equal '\(expectedKey)'.", file: file, line: line)
            } else {
                XCTFail("Expected '.keyNotFound(\(expectedKey))' but got \(error)", file: file, line: line)
            }
        }
    }
}
