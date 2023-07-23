//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 19.06.2023.
//

import Foundation
import SwiftKeychainWrapper


final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    
    private let keychainWrapper = KeychainWrapper.standard
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: "newToken")
            
        } set {
            
            guard let token = newValue else {return}
            let isSuccess = KeychainWrapper.standard.set(token, forKey: "newToken")
            guard isSuccess else { return }
            }
            
        }
    }



