//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 05.07.2023.
//

import Foundation

struct ProfileResult: Decodable {
    let userName: String?
    let firstName: String?
    let lastName: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case bio = "bio"
    }
}
