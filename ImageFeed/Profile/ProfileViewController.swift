//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Albina Musugalieva on 15.03.2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserImageView()
        setupUserNameLabel()
        setupDescriptionLabel()
        setupLoginLabel()
        setupLogoutButton()
        
    }
    
    private func setupUserImageView(){
        let profileImage = UIImage(named: "Photo")
        let imageView = UIImageView(image: profileImage)
        imageView.tintColor = .ypBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 76).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    private func setupUserNameLabel(){
        let usernameLabel = UILabel()
        usernameLabel.text = "Екатерина Новикова"
        usernameLabel.textColor = .ypWhite
        usernameLabel.font = UIFont.systemFont(ofSize: 23)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameLabel)
        usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 154).isActive = true
        usernameLabel.widthAnchor.constraint(equalToConstant: 235).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func setupDescriptionLabel(){
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Hello,world!"
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 206).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 77).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func setupLoginLabel(){
        let loginLabel = UILabel()
        loginLabel.text = "@ekaterina_nov"
        loginLabel.textColor = .ypWhite
        loginLabel.font = UIFont.systemFont(ofSize: 13)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        loginLabel.widthAnchor.constraint(equalToConstant: 99).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    private func setupLogoutButton(){
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Exit"), for: .normal)
        button.tintColor = .ypRed
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 327).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 89).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    
}
