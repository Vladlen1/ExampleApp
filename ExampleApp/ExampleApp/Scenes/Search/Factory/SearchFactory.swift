//
//  SearchFactory.swift
//  ExampleApp
//
//  Created by Vlad Birukov on 2023-09-23.
//

import UIKit

final class SearchFactory {
    
    @MainActor
    func makeSearchViewController() -> UIViewController {
        let networkManger = NetworkManager()
        let viewModel = SearchViewModel(networkManager: networkManger)

        return SearchViewController(viewModel: viewModel)
    }
}
