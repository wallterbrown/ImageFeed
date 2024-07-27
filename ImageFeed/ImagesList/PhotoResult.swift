//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 27.07.2024.
//

import Foundation

struct PhotoResult: Decodable {
    let id: String
    let createdAt: String
    let updatedAt: String
    let width: Int
    let height: Int
    let likes: Int
    let likedByUser: Bool
    let description: String?
    let urls: UrlsResult
}

struct UrlsResult: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
