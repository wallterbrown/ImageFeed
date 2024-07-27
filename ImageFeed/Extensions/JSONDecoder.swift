//
//  JSONDecoder.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 24.07.2024.
//

import Foundation

final class SnakeCaseJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
