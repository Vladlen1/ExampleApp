//
//  Album.swift
//  ExampleApp
//
//  Created by Vlad Birukov on 2023-09-23.
//

import Foundation

struct Album: Decodable, Sendable {
    let wrapperType: String
    let collectionType: String
    let artistId: Int
    let collectionId: Int
    let amgArtistId: Int?
    let artistName: String
    let collectionName: String
    let collectionCensoredName: String
    let artistViewUrl: URL?
    let collectionViewUrl: URL?
    let artworkUrl60: URL?
    let artworkUrl100: URL?
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String?
    let country: String
    let currency: String
    let releaseDate: String
    let primaryGenreName: String
    let contentAdvisoryRating: String?
}
