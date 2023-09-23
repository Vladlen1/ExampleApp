//
//  SearchViewModel.swift
//  ExampleApp
//
//  Created by Vlad Birukov on 2023-09-23.
//

import Foundation

@MainActor
protocol SearchViewModelProtocol {
    var viewModelCells: [SearchViewModelCell] { get }
    
    func fetchAlbums(for artistName: String?, completion: @escaping (Error?) -> Void)
}

final class SearchViewModel: SearchViewModelProtocol {
    private let networkManager: NetworkManagerProtocol
    private let defaultArtistName = "thebeatles"
    private var currentSearchText = ""
    
    var viewModelCells = [SearchViewModelCell]()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchAlbums(for artistName: String?, completion: @escaping (Error?) -> Void) {
        let searchString = artistName ?? defaultArtistName
        if currentSearchText != searchString {
            currentSearchText = searchString

            Task { @MainActor in
                do {
                    let result: SearchResult = try await networkManager.fetchAlbums(for: searchString)
                    viewModelCells = result.results.map { SearchViewModelCell(collectionName: $0.collectionName) }
                    completion(nil)
                } catch {
                    viewModelCells.removeAll()
                    completion(error)
                }
            }
        } else {
            completion(nil)
        }
    }
}
