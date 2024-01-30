//
//  NetworkError.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 22.11.2023.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}
