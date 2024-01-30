//
//  Array Extension.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 04.01.2024.
//

import Foundation

extension Array {
    func withReplaced(itemAt: Int, newValue: Photo) -> [Photo] {
        var photos = ImagesListService.shared.photos
        photos.replaceSubrange(itemAt...itemAt, with: [newValue])
        return photos
    }
}
