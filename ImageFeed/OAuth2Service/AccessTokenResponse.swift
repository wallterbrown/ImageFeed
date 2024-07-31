//
//  AccessTokenResponse.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 04.07.2024.
//

import Foundation

struct OAuthTokenResponse: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}
