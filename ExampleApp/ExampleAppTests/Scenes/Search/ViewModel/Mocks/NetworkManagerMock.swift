//
//  NetworkManagerMock.swift
//  ExampleAppTests
//
//  Created by Vlad Birukov on 2023-09-23.
//

import XCTest
@testable import ExampleApp

final class NetworkManagerMock: NetworkManagerProtocol {
    private let albums: SearchResult
    private let error: Error
    private let defaultSearchText: String
    
    init(
        albums: SearchResult,
        error: Error,
        defaultSearchText: String
    ) {
        self.albums = albums
        self.error = error
        self.defaultSearchText = defaultSearchText
    }
    
    private(set) var isCalledFetchAlbums = false
    func fetchAlbums<T>(for artistName: String) async throws -> T where T : Decodable {
        isCalledFetchAlbums = true
        if artistName == defaultSearchText {
            throw error
        } else {
            guard let result = albums as? T else {
                throw error
            }
            return result
        }
    }
}
