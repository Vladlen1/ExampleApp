//
//  SearchResult.swift
//  ExampleApp
//
//  Created by Vlad Birukov on 2023-09-23.
//

import Foundation

struct SearchResult: Decodable, Sendable {
    let resultCount: Int
    let results: [Album]
}
