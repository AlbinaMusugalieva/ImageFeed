//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Albina Musugalieva on 03.05.2026.
//

import Foundation
@testable import ImageFeed

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ImageFeed.ProfilePresenterProtocol?

    var updateProfileDetailsCalled: Bool = false
    var updateAvatarCalled: Bool = false

    func updateProfileDetails(profile: Profile){
        updateProfileDetailsCalled = true
    }
    func updateAvatar(){
        updateAvatarCalled = true
    }
}
