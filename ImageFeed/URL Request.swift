//
//  URL Request.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 05.07.2023.
//

import Foundation


// MARK: - HTTP Request

extension URLRequest {
    static func makeHTTPRequest(
        path: String,
        httpMethod: String,
        baseURLString: String) -> URLRequest? {
            guard
                let url = URL(string: baseURLString),
                let baseUrl = URL(string: path, relativeTo: url)
            else { return nil}
            
            var request = URLRequest(url: baseUrl)
            request.httpMethod = httpMethod
            
           if let token = OAuth2TokenStorage.shared.token {
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Auhtorization")
            }
            return request
        }
}
