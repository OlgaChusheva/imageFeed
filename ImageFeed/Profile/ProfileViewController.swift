import UIKit

final class ProfileViewController: UIViewController {
         
    override func viewDidLoad() {
            super.viewDidLoad()
        
        addSubViews()
        applyConstraints()
    }
    
    private var label: UILabel = {
         let label = UILabel()
        return label
    }()
           
    private let imageView: UIImageView = {
        let profilImage = UIImage(named: "Photo")
        let imageView = UIImageView(image: profilImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userName: UILabel = {
        let userName = UILabel()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.text = "Екатерина Новикова"
        userName.textColor = .white
        userName.font = .systemFont(ofSize: 23, weight: .medium)
        return userName
    }()
    
    private let profilName: UILabel = {
        let profilName = UILabel()
        profilName.translatesAutoresizingMaskIntoConstraints = false
        profilName.text = "@ekaterina_nov"
        profilName.textColor = .gray
        profilName.font = .systemFont(ofSize: 13, weight: .regular)
        return profilName
    }()

    private let textName: UILabel = {
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
    
    private func addSubViews() {
        view.addSubview(imageView)
        view.addSubview(userName)
        view.addSubview(profilName)
        view.addSubview(textName)
        view.addSubview(button)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 52),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            userName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            userName.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            profilName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
            profilName.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            textName.topAnchor.constraint(equalTo: profilName.bottomAnchor, constant: 8),
            textName.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)])
    }

    @objc
    private func didTapButton() {
        label.removeFromSuperview()
    }
}

