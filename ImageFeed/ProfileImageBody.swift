//
//  ProfileImageBody.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 25.07.2024.
//

import Foundation
struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

struct ProfileImageResult: Codable {
    let profileImage: ProfileImage
}
