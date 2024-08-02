//
//  ProfileViewPresenter.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 31.07.2024.
//

import Foundation

public protocol ProfileViewPresenterProtocol {
    var view: ProfileViewViewControllerProtocol? { get set }
    func viewDidLoad()
    func logout()
    func didUpdateAvatar()
}

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    
    weak var view: ProfileViewViewControllerProtocol?
    
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let profileLogoutService = ProfileLogoutService.shared
    
    func viewDidLoad() {
        guard let profileData = profileService.profile else {
            return
        }
        
        view?.addProfileImgeView()
        view?.addUserNameLabel(profileData.name)
        view?.addUserIdLabel(profileData.loginName)
        view?.addUserTextLabel(profileData.bio)
        view?.addExitButton()
        didUpdateAvatar()
    }
    
    func didUpdateAvatar() {
        guard
            let profileImageURL = profileImageService.avatarURL,
            let imageUrl = URL(string: profileImageURL)
        else { return }
        
        view?.updateAvatar(imageUrl: imageUrl)
    }
    
    func logout() {
        profileLogoutService.logout()
    }
}
