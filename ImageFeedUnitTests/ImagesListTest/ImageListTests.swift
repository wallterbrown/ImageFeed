//
//  ImageFeedTests.swift
//  ImageFeedTests
//
//  Created by Всеволод Нагаев on 31.07.2024.
//
@testable import ImageFeed
import XCTest

final class ImageListTests: XCTestCase {
    func testViewControllerCallsFetchPhotosNextPage() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImagesListPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.fetchPhotosNextPageCalled)
    }
    
    func testCellHeight() {
        
        let presenter = ImagesListPresenter()
        presenter.photos = [
            Photo(
                id: "1",
                size: CGSize(width: 100, height: 100),
                createdAt: nil,
                welcomeDescription: nil,
                thumbImageURL: "https://image.com/1",
                largeImageURL: "https://image.com/2",
                isLiked: false
            )
        ]
        
        let cellHeight = presenter.getCellHeight(100, 0)
        
        XCTAssertEqual(cellHeight, 76)
    }
}

