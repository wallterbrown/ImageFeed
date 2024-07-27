//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 29.05.2024.
//
import UIKit
import Kingfisher
final class ProfileViewController: UIViewController{
    
    private var avatarImageView: UIImageView?
    private var exitButton: UIButton?
    private var userNameLable: UILabel?
    private var loginNameLable: UILabel?
    private var descriptionLabel: UILabel?
    
    private var profileImageServiceObserver: NSObjectProtocol?
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let profileService = ProfileService.shared
    private let tokenStorage = OAuth2TokenStorage.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.ypBlack
        setUI()
        updateProfileDetails()
        
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
    }
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let imageURL = URL(string: profileImageURL)
        else { return }
        profileImageView.kf.indicatorType = .activity
        profileImageView.kf.setImage(with: imageURL, placeholder: UIImage(named: "profile-placeholder"))
    }
    
    private func setUI(){
        setAvatarImage()
        setExitButton()
        setNameLabel()
        setLoginLabel()
        setDescriptionLabel()
    }
    
    private func updateProfileDetails() {
        guard let token = tokenStorage.token else {
            print("Token is missing.")
            return
        }
        
        profileService.fetchProfile(token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self.userNameLable?.text = profile.name
                    self.loginNameLable?.text = profile.loginName
                    self.descriptionLabel?.text = profile.bio
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print("Error fetching profile: \(error)")
                }
            }
        }
    }
    
    private func setAvatarImage() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 70),
            profileImageView.widthAnchor.constraint(equalToConstant: 70),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            profileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        
        profileImageView.layer.cornerRadius = 35
        
        self.avatarImageView = profileImageView
    }
    
    private func setExitButton(){
        let exitButton = UIButton.systemButton(with: UIImage(named: "Exit") ?? UIImage(),
                                               target: self,
                                               action: #selector(self.exitButtonDidTap))
        
        exitButton.tintColor = .ypRed
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            exitButton.heightAnchor.constraint(equalToConstant: 44),
            exitButton.widthAnchor.constraint(equalToConstant: 44),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        if let avatarImageView {
            exitButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        }
        
        self.exitButton = exitButton
    }
    
    
    private func setNameLabel() {
        let userNameLabel = UILabel()
        
        userNameLabel.text = "Екатерина Новикова"
        userNameLabel.textColor = .ypWhite
        userNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        
        if let avatarImageView {
            NSLayoutConstraint.activate([
                userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
                userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8)
            ])
        }
        
        self.userNameLable = userNameLabel
    }
    
    private func setLoginLabel() {
        let loginNameLabel = UILabel()
        
        loginNameLabel.text = "@ekaterina_nov"
        loginNameLabel.textColor = .ypGray
        loginNameLabel.font = UIFont.systemFont(ofSize: 13)
        
        loginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginNameLabel)
        
        if let avatarImageView {
            loginNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        }
        if let userNameLable {
            loginNameLabel.topAnchor.constraint(equalTo: userNameLable.bottomAnchor, constant: 8).isActive = true
        }
        
        self.loginNameLable = loginNameLabel
    }
    
    private func setDescriptionLabel() {
        let descriptionLabel = UILabel()
        
        descriptionLabel.text = "Hello, world!"
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
        
        if let avatarImageView {
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        }
        if let loginNameLable {
            descriptionLabel.topAnchor.constraint(equalTo: loginNameLable.bottomAnchor, constant: 8).isActive = true
        }
        self.descriptionLabel = descriptionLabel
    }
    
    @objc
    private func exitButtonDidTap(){
        print("ExitButtonTapped")
    }
}

