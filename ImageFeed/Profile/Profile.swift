//
//  Profile.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 05.07.2023.
//

import Foundation

struct Profile {
    var username: String
    var name: String
    var loginName: String
    var bio: String
    init(profileResult: ProfileResult) {
        self.username = profileResult.username
        self.name = "\(profileResult.firstName ?? "") \(profileResult.lastName ?? "")"
        self.loginName = "@\(profileResult.username)"
        self.bio = profileResult.bio ?? ""
    }
}
