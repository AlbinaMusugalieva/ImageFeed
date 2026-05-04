//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Albina Musugalieva on 03.05.2026.
//

import Foundation

protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? {get set}
    func viewDidLoad()
    func tapLogoutButton()
}

final class ProfilePresenter: ProfilePresenterProtocol{
    weak var view: ProfileViewControllerProtocol?
    private var profileImageServiceObserver: NSObjectProtocol?
    
    func viewDidLoad(){
        if let profile = ProfileService.shared.profile {
            view?.updateProfileDetails(profile: profile)
        }
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                view?.updateAvatar()
            }
        view?.updateAvatar()
    }
    
    func tapLogoutButton() {
        ProfileLogoutService.shared.logout()
    }
}
