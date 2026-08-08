//
//  ImageListPresenterSpry.swift
//  ImageFeedTests
//
//  Created by Albina Musugalieva on 03.05.2026.
//

import Foundation
@testable import ImageFeed

final class ImageListPresenterSpy: ImageListPresenterProtocol {
    var view: ImagesListViewControllerProtocol? 
    var viewDidLoadCalled: Bool = false
    var loadCalled: Bool = false
    var tapLikeCalled = false
    var photos: [Photo] = []
    func viewDidLoad(){
        viewDidLoadCalled = true
    }
    func load(){
        loadCalled = true
    }
    func tapLike(_ index: IndexPath, _ cell: ImagesListCell){
        tapLikeCalled = true
    }
}
