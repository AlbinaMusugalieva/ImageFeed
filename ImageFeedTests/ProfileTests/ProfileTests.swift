//
//  ProfileTests.swift
//  ImageFeedTests
//
//  Created by Albina Musugalieva on 03.05.2026.
//

import XCTest
@testable import ImageFeed

@MainActor

final class ProfileTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        //given
        let viewController = ProfileViewController()
        let presenter = ProfilePresenterSpy()
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsLoadRequest() {
        //given
        let viewController = ProfileViewControllerSpy()
        let presenter = ProfilePresenter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        presenter.viewDidLoad()
        
        //then
        XCTAssertTrue(viewController.updateProfileDetailsCalled)
        XCTAssertTrue(viewController.updateAvatarCalled)
    }
    
}
