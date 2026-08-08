//
//  ImagesListTests.swift
//  ImageFeedTests
//
//  Created by Albina Musugalieva on 03.05.2026.
//


import XCTest
@testable import ImageFeed

@MainActor

final class ImagesListTests: XCTestCase {
    
    func testViewControllerCallsViewDidLoad() {
        //given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController") as! ImagesListViewController
        let presenter = ImageListPresenterSpy()
        viewController.configure(presenter)
        
        //when
        _ = viewController.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsLoadRequest() async{
        //given
        let viewController = ImagesListViewControllerSpy()
        let presenter = ImageListPresenter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        
        //when
        presenter.viewDidLoad()
        
        //then
        XCTAssertTrue(viewController.updateTableViewAnimatedCalled)
    }
}
