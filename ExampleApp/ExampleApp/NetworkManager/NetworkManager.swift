//
//  NetworkManager.swift
//  ExampleApp
//
//  Created by Vlad Birukov on 2023-09-23.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchAlbums<T: Decodable>(for artistName: String) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {

    func fetchAlbums<T: Decodable>(for artistName: String) async throws -> T {
        guard let url = searchUrl(with: artistName) else {
            throw AlbumError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
    private func searchUrl(with artistName: String) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.sheme
        components.host = Constants.host
        components.path = Constants.path

        components.queryItems = [
            URLQueryItem(name: Constants.term, value: artistName),
            URLQueryItem(name: Constants.media, value: "music"),
            URLQueryItem(name: Constants.entity, value: "album"),
            URLQueryItem(name: Constants.attribute, value: "artistTerm")
        ]
        
        return URL(string: components.string ?? "")
    }
}

// MARK: - Helper

extension NetworkManager {
    private struct Constants {
        static let sheme = "https"
        static let host = "itunes.apple.com"
        static let path = "/search"
        static let term = "term"
        static let media = "media"
        static let entity = "entity"
        static let attribute = "attribute"
    }
    
    private enum AlbumError: Error {
        case invalidURL
    }
}
