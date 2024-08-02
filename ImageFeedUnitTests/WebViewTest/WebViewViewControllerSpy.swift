//
//  WebViewViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Всеволод Нагаев on 31.07.2024.
//
import ImageFeed
import Foundation

final class WebViewViewControllerSpy: WebViewViewControllerProtocol {
    var loadRequestCalled: Bool = false
    var presenter: (any ImageFeed.WebViewPresenterProtocol)?
    
    func load(request: URLRequest) {
        loadRequestCalled = true
    }
    
    func setProgressValue(_ newValue: Float, animated: Bool) {}
    
    func setProgressHidden(_ isHidden: Bool) {}
}
