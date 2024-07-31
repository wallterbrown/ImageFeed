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
        //given
        let viewController = ProfileViewController()
        let presenter = ProfileViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
}
