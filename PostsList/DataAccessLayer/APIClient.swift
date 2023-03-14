//
//  APIClient.swift
//  PostsList
//
//  Created by Dimo Abdelaziz on 09/03/2023.
//

import Foundation
import UIKit

// MARK: - URLSession
protocol URLSessionProtocol {
    func data(with url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    func data(with url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url)
    }
}

final class APIClient {

    private let session: URLSessionProtocol
    private let decoder: JSONDecoder

    init(withSession session: URLSessionProtocol = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
        //TODO: Move this code to better places
        decoder.userInfo[CodingUserInfoKey.managedObjectContext] = CoreDataManager.shared.viewContext
    }

    func loadData<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await session.data(with: url)
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200 else {
            throw PostsListError.invalidServerResponse
        }
        return try decoder.decode(T.self, from: data)
    }
}
