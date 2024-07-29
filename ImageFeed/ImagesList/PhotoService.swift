//
//  PhotoService.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 27.07.2024.
//

import Foundation

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    var isLiked: Bool
}
