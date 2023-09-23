//
//  SearchViewModelTests.swift
//  ExampleAppTests
//
//  Created by Vlad Birukov on 2023-09-23.
//

import XCTest
@testable import ExampleApp

final class SearchViewModelTests: XCTestCase {
    private var sut: SearchViewModel!
    private var networkMangerMock: NetworkManagerMock!
    
    @MainActor
    override func setUp() {
        networkMangerMock = NetworkManagerMock(
            albums: TestData.searchResult,
            error: TestData.error,
            defaultSearchText: TestData.defaultSearch
        )
        sut = SearchViewModel(networkManager: networkMangerMock)
    }

    override func tearDown() {
        networkMangerMock = nil
        sut = nil
    }

    @MainActor
    func testFetchAlbumsSuccess() {
        let expectation = expectation(description: TestData.fetchAlbumss)
        
        sut.fetchAlbums(for: TestData.searchText) { error in
            XCTAssertTrue(self.networkMangerMock.isCalledFetchAlbums)
            XCTAssertNil(error)
            XCTAssertEqual(self.sut.viewModelCells.count, TestData.resultCount)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
        
    @MainActor
    func testFetchAlbumsFailure() {
        let expectation = expectation(description: TestData.fetchAlbumss)
        
        sut.fetchAlbums(for: TestData.defaultSearch) { error in
            XCTAssertTrue(self.networkMangerMock.isCalledFetchAlbums)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    @MainActor
    func testFetchAlbumsTheSameSearch() {
        let expectation = expectation(description: TestData.fetchAlbumss)
        
        sut.fetchAlbums(for: TestData.searchText) { _ in}
        sut.fetchAlbums(for: TestData.searchText) {  error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}

extension SearchViewModelTests {
    enum TestData {
        static let searchResult = SearchResult(
            resultCount: resultCount,
            results: Array(repeating: album, count: resultCount)
        )
        static let fetchAlbumss = "Fetch Albums"
        static let defaultSearch = "thebeatles"
        static let searchText = "ladyGaga"
        static let resultCount = 3
        static let album = Album(
            wrapperType: "SampleWrapperType",
            collectionType: "SampleCollectionType",
            artistId: 0,
            collectionId: 0,
            amgArtistId: nil,
            artistName: "SampleArtistName",
            collectionName: "SampleCollectionName",
            collectionCensoredName: "SampleCollectionCensoredName",
            artistViewUrl: nil,
            collectionViewUrl: nil,
            artworkUrl60: nil,
            artworkUrl100: nil,
            collectionPrice: nil,
            collectionExplicitness: "SampleCollectionExplicitness",
            trackCount: 0,
            copyright: nil,
            country: "SampleCountry",
            currency: "SampleCurrency",
            releaseDate: "SampleReleaseDate",
            primaryGenreName: "SamplePrimaryGenreName",
            contentAdvisoryRating: nil
        )
        static let error = TestError.fetchError
        
        enum TestError: Error {
            case fetchError
        }
    }
}
