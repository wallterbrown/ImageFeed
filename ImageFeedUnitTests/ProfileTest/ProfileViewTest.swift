//
//  ProfileViewTest.swift
//  ImageFeedTests
//
//  Created by Всеволод Нагаев on 31.07.2024.
//

@testable import ImageFeed
import XCTest

final class ProfileViewTest: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
}
