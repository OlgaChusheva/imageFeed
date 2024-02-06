//
//  ProfileUnitTests.swift
//  ImageFeedTests
//
//  Created by Ольга Чушева on 31.01.2024.
//


import XCTest
@testable import ImageFeed

final class ProfileUnitTests: XCTestCase {
   
    func testProfileViewLogoutTokenIsEqualNil() {
        //given
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter()
        viewController.configure(presenter)
        
        //when
        presenter.logout()
        
        //then
        XCTAssertEqual(OAuth2TokenStorage().token, nil)
    }
    

    
    func testProfilePresenterChangedViewControllerAfterLogout() {
        //given
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        presenter.logout()
        
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid Configuration")
            return
        }
        
        //then
        XCTAssertTrue(window.rootViewController?.isKind(of: SplashViewController.self) == true) //behaviour verification
    }
}
