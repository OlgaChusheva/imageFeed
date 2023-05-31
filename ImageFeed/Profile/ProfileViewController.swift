//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 14.05.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    private var label: UILabel?
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    @IBOutlet private var logoutButton: UIButton!
    
    @IBAction private func didTapLogoutButton() {
    }

    override func viewDidLoad() {
            super.viewDidLoad()
            
        let profilImage = UIImage(named: "Photo")
        let imageView = UIImageView(image: profilImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Екатерина Новикова"
        userName.textColor = .white
        userName.font = .systemFont(ofSize: 23, weight: .medium)
        view.addSubview(userName)
        //userName.heightAnchor.constraint(equalToConstant: 23).isActive = true
        userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        userName.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        
        let profilName = UILabel()
        profilName.translatesAutoresizingMaskIntoConstraints = false
        profilName.text = "@ekaterina_nov"
        profilName.textColor = .gray
        profilName.font = .systemFont(ofSize: 13, weight: .regular)
        view.addSubview(profilName)
        profilName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8).isActive = true
        profilName.leadingAnchor.constraint(equalTo: userName.leadingAnchor).isActive = true
        
        let textName = UILabel()
        textName.translatesAutoresizingMaskIntoConstraints = false
        textName.text = "Hello, world!"
        textName.textColor = .white
        textName.font = .systemFont(ofSize: 13)
        view.addSubview(textName)
        textName.topAnchor.constraint(equalTo: profilName.bottomAnchor, constant: 8).isActive = true
        textName.leadingAnchor.constraint(equalTo: userName.leadingAnchor).isActive = true
        
        let button = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: self,
            action: #selector(Self.didTapButton))
        
        button.tintColor = UIColor(named: "YP Red")
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        
        
            
        
    }

    @objc
    private func didTapButton(){
        label?.removeFromSuperview()
        label = nil
    }


}

