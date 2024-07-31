//
//  WebViewTest.swift
//  ImageFeedTests
//
//  Created by Всеволод Нагаев on 31.07.2024.
//

@testable import ImageFeed
import XCTest

final class WebViewTest: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as! WebViewViewController
        let presenter = WebViewPresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        _ = viewController.view
        
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsLoadRequest() {
        
        let viewController = WebViewViewControllerSpy()
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        viewController.presenter = presenter
        presenter.view = viewController
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(viewController.loadRequestCalled)
    }
    
    func testProgressVisibleWhenLessThenOne() {
        
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 0.6
        
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        
        XCTAssertFalse(shouldHideProgress)
    }
    
    func testProgressVisibleWhenOne() {
        
        let authHelper = AuthHelper()
        let presenter = WebViewPresenter(authHelper: authHelper)
        let progress: Float = 1
        
        let shouldHideProgress = presenter.shouldHideProgress(for: progress)
        
        XCTAssertTrue(shouldHideProgress)
    }
    
    func testAuthHelperAuthURL() {
        
        let configuration = AuthConfiguration.standard
        let authHelper = AuthHelper(configuration: configuration)
        
        let url = authHelper.authURL()
        
        XCTAssertNotNil(url, "URL should not be nil")
        
        if let url = url {
            let urlString = url.absoluteString
            
            XCTAssertTrue(urlString.contains(configuration.authURLString))
            XCTAssertTrue(urlString.contains(configuration.accessKey))
            XCTAssertTrue(urlString.contains(configuration.redirectURI))
            XCTAssertTrue(urlString.contains("code"))
            XCTAssertTrue(urlString.contains(configuration.accessScope))
        }
    }
    
    func testCodeFromURL() {
        
        var urlComponents = URLComponents(string: "https://unsplash.com/oauth/authorize/native")!
        urlComponents.queryItems = [URLQueryItem(name: "code", value: "test")]
        let url = urlComponents.url!
        let authHelper = AuthHelper()
        
        let code = authHelper.code(from: url)
        
        XCTAssertEqual(code, "test")
    }
}
