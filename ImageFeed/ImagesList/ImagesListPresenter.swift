//
//  ImagesListPresenter.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 02.01.2024.
//

import Foundation

public protocol ImagesListPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }
    func dateString(_ date: Date) -> String
}

final class ImagesListPresenter: ImagesListPresenterProtocol {
    weak var view: ImagesListViewControllerProtocol?
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    public func dateString(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
