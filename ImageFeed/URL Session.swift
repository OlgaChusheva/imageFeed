//
//  URL Session.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 03.07.2023.
//

import Foundation

enum NetwokError: Error {
    case decodingError(Error)
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case invalidRequest
}

