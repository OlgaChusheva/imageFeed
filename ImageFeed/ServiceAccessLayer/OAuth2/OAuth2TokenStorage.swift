//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 19.06.2023.
//

import Foundation

final class OAuth2TokenStorage {
    var token: String? {
        
        get {
            UserDefaults.standard.string(forKey: "newToken")
            
        } set {
            
            let defaults = UserDefaults.standard
            if let name = newValue {
                defaults.set(name, forKey: "newToken")
            }
            
        }
    }
}


