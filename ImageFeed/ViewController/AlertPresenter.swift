//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 09.07.2023.
//

import Foundation

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}

protocol AlertPresenterProtocol {
    func showAlert(alertModel: AlertModel)
}

final class AlertPresenter {
    private weak var alertController: UIViewController?
    
    init(alertController: UIViewController? = nil) {
        self.alertController = alertController
    }
    
    func showAlert(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: alertModel.buttonText, style: .default) { _ in
            alertModel.completion()
        }
        alert.addAction(action)
        alertController?.present(alert, animated: true, completion: nil)
    }
}
