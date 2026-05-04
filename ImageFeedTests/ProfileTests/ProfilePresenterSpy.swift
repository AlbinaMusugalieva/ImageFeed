//
//  ProfilePresenterSpy.swift
//  ImageFeedTests
//
//  Created by Albina Musugalieva on 03.05.2026.
//

import Foundation
@testable import ImageFeed

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var tapLogoutButtonCalled: Bool = false
    var view: ProfileViewControllerProtocol?
    func viewDidLoad(){
        viewDidLoadCalled = true
    }
    func tapLogoutButton(){
        tapLogoutButtonCalled = true
    }
}

