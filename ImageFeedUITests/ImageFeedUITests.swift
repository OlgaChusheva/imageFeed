//
//  ImageFeedUITests2.swift
//  ImageFeedUITests2
//
//  Created by Ольга Чушева on 31.01.2024.
//

import XCTest

extension XCUIElement {
    func tapUnhittable() {
        XCTContext.runActivity(named: "Tap \(self) by coordinate") { _ in
            coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }
    }
}

final class ImageFeedUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
    }
    
    func testAuth() throws {
        
        app/*@START_MENU_TOKEN@*/.buttons["Authenticate"]/*[[".buttons[\"Войти\"]",".buttons[\"Authenticate\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let webView = app.webViews["UnsplashWebView"]
        
        sleep(2)
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        
        sleep(5)
        
        
        loginTextField.tap()
        loginTextField.typeText("helga_ever@mail.ru")
        
        sleep(3)
        
        webView.descendants(matching: .secureTextField).element.tap()
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        
        sleep(5)
        
        passwordTextField.tap()
        passwordTextField.typeText("28NewLife")
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    
    
    func testFeed() throws {
                
        let tablesQuery = app.tables["ImageList"]
        
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        
        cellToLike.buttons["LikeButton"].tap()
        cellToLike.buttons["LikeButton"].tap()
        
        sleep(2)
        
        cellToLike.tap()
        
        sleep(2)
        
        let image = app.scrollViews.images.element(boundBy: 0)
        // Zoom in
        image.pinch(withScale: 3, velocity: 1) // zoom in
        // Zoom out
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButtonWhiteButton = app.buttons["nav back button"]
        navBackButtonWhiteButton.tap()

        }
    
    func testProfile() throws {
        sleep(3)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        // MARK: - Name + Lastname + @username
        XCTAssertTrue(app.staticTexts["Olga Chusheva"].exists)
        XCTAssertTrue(app.staticTexts["@olga_chushvea"].exists)
        
        app.buttons["Logout Button"].tap()
        
        app.alerts["Logout Alert"].scrollViews.otherElements.buttons["Yes"].tap()
    }
}
