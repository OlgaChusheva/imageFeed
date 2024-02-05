//
//  ImagesListUnitTest.swift
//  ImageFeedTests
//
//  Created by Ольга Чушева on 31.01.2024.
//

import XCTest
@testable import ImageFeed

final class ImagesListUnitTest: XCTestCase {
    
    func testDateToString() {
        //given
        let viewController = ImagesListViewController()
        let presenter = ImagesListPresenter()
        viewController.configure(presenter)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date = formatter.date(from: "2022/08/31 22:31") else {
            return
        }
        
        //when
        let code = presenter.dateString(date)
        
        //then
        XCTAssertEqual(code, "31 August 2022")
    }
    
    func testInvalidDateToString() {
        //given
        let viewController = ImagesListViewController()
        let presenter = ImagesListPresenter()
        viewController.configure(presenter)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        guard let date = formatter.date(from: "2022/08/31 22:31") else {
            return
        }
        
        //when
        let code = presenter.dateString(date)
        
        //then
        XCTAssertFalse(code == "30 августа 2022 г.")
    }
}

