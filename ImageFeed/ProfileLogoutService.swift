//
//  ProfileLogoutService.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 27.07.2024.
//

import Foundation

import WebKit

final class ProfileLogoutService {
    static let shared = ProfileLogoutService()
    
    private let profileImageService = ProfileImageService.shared
    private let imagesListService = ImagesListService.shared
    private let profileService = ProfileService.shared
    
    private init() {}
    
    func logout() {
        cleanTokenStorage()
        cleanCookies()
        UIBlockingProgressHUD.show()
        cleanCookies()
        profileService.cleanProfile()
        profileImageService.cleanProfileImage()
        imagesListService.cleanPhotos()
        UIBlockingProgressHUD.dismiss()
    }
    
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    private func cleanTokenStorage() {
        OAuth2TokenStorage.shared.token = nil
    }
}

