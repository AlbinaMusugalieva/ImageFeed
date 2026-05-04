//
//  ImagesListViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Albina Musugalieva on 03.05.2026.
//

import Foundation
@testable import ImageFeed

final class ImagesListViewControllerSpy: ImagesListViewControllerProtocol {
    var presenter: ImageFeed.ImageListPresenterProtocol?
    
    var updateTableViewAnimatedCalled: Bool = false
    var showErrorCalled: Bool = false
    
    
    func updateTableViewAnimated(oldCount: Int, newCount: Int){
        updateTableViewAnimatedCalled = true
    }
    func showError(){
        showErrorCalled = true
    }
}
