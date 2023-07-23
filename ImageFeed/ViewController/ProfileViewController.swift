import UIKit
import Kingfisher
import SwiftKeychainWrapper

final class ProfileViewController: UIViewController {
    
    private let profileService = ProfileService.shared
    
    private var profileImageServiceObserver: NSObjectProtocol?
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage (named: "user_placeholder")
        imageView.setValue(true, forKeyPath: "layer.masksToBounds")
        imageView.setValue(35, forKeyPath: "layer.cornerRadius")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let userNameLabel: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Екатерина Новикова"
        userName.textColor = .white
        userName.font = .systemFont(ofSize: 23, weight: .medium)
        return userName
    }()
    
    private let loginNameLabel: UILabel = {
        let profilName = UILabel()
        profilName.translatesAutoresizingMaskIntoConstraints = false
        profilName.text = "@ekaterina_nov"
        profilName.textColor = .gray
        profilName.font = .systemFont(ofSize: 13, weight: .regular)
        return profilName
    }()
    
    private let profileTextLabel: UILabel = {
        let textName = UILabel()
        textName.translatesAutoresizingMaskIntoConstraints = false
        textName.text = "Hello, world!"
        textName.textColor = .white
        textName.font = .systemFont(ofSize: 13)
        return textName
    }()
    
    private let button: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: ProfileViewController.self,
            action: #selector(Self.didTapButton))
        button.tintColor = UIColor(named: "YP Red")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "YP_Black")
        
        button.isHidden = false
        updateProfileDetails(profile: profileService.profile)
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.DidChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateAvatar()
            }
        updateAvatar()
        addSubViews()
        applyConstraints()
    }
    
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        userImageView.kf.indicatorType = .activity
        userImageView.kf.setImage(with: url,
                                  placeholder: UIImage(named: "user_placeholder"),
                                  options: [.forceRefresh])
    }
    
    private func updateProfileDetails(profile: Profile?) {
        guard let profile = profile else { return }
        userNameLabel.text = profile.name
        loginNameLabel.text = profile.loginName
        profileTextLabel.text = profile.bio
    }
    
    private func addSubViews() {
        view.addSubview(userImageView)
        view.addSubview(userNameLabel)
        view.addSubview(loginNameLabel)
        view.addSubview(profileTextLabel)
        view.addSubview(button)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            userImageView.widthAnchor.constraint(equalToConstant: 70),
            userImageView.heightAnchor.constraint(equalToConstant: 70),
            userNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
            userNameLabel.leadingAnchor.constraint(equalTo: userImageView.leadingAnchor),
            loginNameLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            loginNameLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            profileTextLabel.topAnchor.constraint(equalTo: loginNameLabel.bottomAnchor, constant: 8),
            profileTextLabel.leadingAnchor.constraint(equalTo: userNameLabel.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            button.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor)])
    }
    
    @objc
    private func didTapButton() {
        print(#function)
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: "newToken")
    }
}

