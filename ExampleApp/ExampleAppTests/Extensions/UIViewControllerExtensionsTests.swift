//
//  UIViewControllerExtensionsTests.swift
//  ExampleAppTests
//
//  Created by Vlad Birukov on 2023-09-23.
//

import UIKit
import XCTest
@testable import ExampleApp 

class UIViewControllerExtensionsTests: XCTestCase {
    private var sut: UIViewController!

    override func setUp() {
        sut = UIViewController()
        keyWindow?.rootViewController = sut
    }

    override func tearDown() {
        sut = nil
        keyWindow?.rootViewController = sut
    }

    func testShowErrorAlert() {
        sut.showErrorAlert(with: TestData.errorMessage)
        
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
    
    private var keyWindow: UIWindow? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.windows.first
        }
        return nil
    }
}

extension UIViewControllerExtensionsTests {
    enum TestData {
        static let errorMessage = "Test Error Message"
    }
}
