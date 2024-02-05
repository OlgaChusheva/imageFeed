import UIKit
import WebKit
import Kingfisher
import SwiftKeychainWrapper

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func switchToSplashViewController()
}

final class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    var presenter: ProfilePresenterProtocol?

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
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(named: "logout")!,
            target: self,
            action: #selector(Self.didTapButton))
        button.tintColor = .ypRed
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "logoutButton"
        return button
    }()
    
    func configure(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "YP_Black")
        
        logoutButton.isHidden = false
        updateProfileDetails(profile: profileService.profile)
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
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
    
    
    func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
        userImageView.kf.indicatorType = .activity
        
        userImageView.kf.setImage(with: url, placeholder: UIImage(named: "user_placeholder"), options: [.forceRefresh])
    }

    private func updateProfileDetails(profile: Profile?) {
        guard let profile = profile else { return }
        userNameLabel.text = profile.name
        loginNameLabel.text = profile.loginName
        profileTextLabel.text = profile.bio
    }
    
 
    
    @objc
    private func didTapButton() {
        showAlert()
    }
    
    func switchToSplashViewController() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Invalid Configuration")
            return
        }
        window.rootViewController = SplashViewController()
    }
    
    func showAlert() {
        let alertController = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйти?",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .default, handler: { [weak self] action in
            guard let self = self else { return }
            self.presenter?.logout()
            
            
        })
        alertController.addAction(action)
        action.accessibilityIdentifier = "Yes"
        alertController.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
        alertController.view.accessibilityIdentifier = "Logout Alert"
        
        present(alertController, animated: true, completion: nil)
        
    }
    
//    func logout() {
//        OAuth2TokenStorage().token = nil
//        cleanServicesData()
//        switchToSplashViewController()
//        print("Hello2")
//        clean()
//    }
//    
//    private func cleanServicesData() {
//        ImagesListService.shared.clean()
//        ProfileService.shared.clean()
//        ProfileImageService.shared.clean()
//    }
//    
//     func clean() {
//        // Очищаем все куки из хранилища
//        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
//        // Запрашиваем все данные из локального хранилища
//        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
//            // Массив полученных записей удаляем из хранилища
//            records.forEach { record in
//                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
//            }
//        }
//    }
    
    private func addSubViews() {
        view.addSubview(userImageView)
        view.addSubview(userNameLabel)
        view.addSubview(loginNameLabel)
        view.addSubview(profileTextLabel)
        view.addSubview(logoutButton)
        logoutButton.accessibilityIdentifier = "Logout Button"
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
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            logoutButton.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor)])
    }
   
}

