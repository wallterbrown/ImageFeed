//
//  AccessTokenResponse.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 04.07.2024.
//

import Foundation

struct OAuthTokenResponse: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
    
    static func decodeTokenResponse(from data: Data) -> Result<String, Error> {
        do {
            let response = try JSONDecoder().decode(OAuthTokenResponse.self, from: data)
            return .success(response.accessToken)
        } catch {
            return .failure(error)
        }
    }
}
