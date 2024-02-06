//
//  WebViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Ольга Чушева on 31.01.2024.
//

import Foundation
import ImageFeed


final class WebViewPresenterSpy: WebViewPresenterProtocol  {
    
    var view: WebViewViewControllerProtocol?
    var viewDidLoadCalled: Bool = false
    
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didUpdateProgressValue(_ newValue: Double) {
        
    }
    
    func code(from url: URL) -> String? {
        return nil
    }
    
}
