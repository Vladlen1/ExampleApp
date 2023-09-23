//
//  SearchTableViewCellTests.swift
//  ExampleAppTests
//
//  Created by Vlad Birukov on 2023-09-23.
//

import XCTest
@testable import ExampleApp

class SearchTableViewCellTests: XCTestCase {
    
    func testCellInitialization() {
        let cell = SearchTableViewCell(style: .default, reuseIdentifier: TestData.reuseIdentifier)
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell.reuseIdentifier, TestData.reuseIdentifier)
    }
    
    func testSetupWithModel() {
        let cell = SearchTableViewCell(style: .default, reuseIdentifier: TestData.reuseIdentifier)
        
        cell.setup(with: TestData.model)
        
        XCTAssertEqual(cell.titleLabel.text, TestData.model.collectionName)
    }
}

extension SearchTableViewCellTests {
    enum TestData {
        static let reuseIdentifier = "SampleReuseIdentifier"
        static let model = SearchViewModelCell(collectionName: "SampleCollectionName")
    }
}
