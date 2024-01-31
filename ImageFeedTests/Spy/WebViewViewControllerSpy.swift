//
//  File.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 31.01.2024.
//

import Foundation


final class WebViewViewControllerSpy:  WebViewViewControllerProtocol {
    var presenter: ImageFeed.WebViewPresenterProtocol?
    
    var loadRequestCalled: Bool = false
        
    func load(request: URLRequest) {
        loadRequestCalled = true
    }
    
    func setProgressValue(_ newValue: Float) {
        
    }
    
    func setProgressHidden(_ isHidden: Bool) {
       
    }
    
}
