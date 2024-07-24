//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 21.07.2024.
//

import Foundation


struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
}

struct Profile {
    let username: String
    let name: String
    let loginName: String
    let bio: String
}
