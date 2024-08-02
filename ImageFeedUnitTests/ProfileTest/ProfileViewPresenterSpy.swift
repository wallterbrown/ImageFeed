//
//  ProfileViewPresenterSpy.swift
//  ImageFeedTests
//
//  Created by Всеволод Нагаев on 31.07.2024.
//
import ImageFeed
import Foundation


final class ProfileViewPresenterSpy: ProfileViewPresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var didUpdateAvatarCalled: Bool = false
    
    var view: (any ImageFeed.ProfileViewViewControllerProtocol)?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func didUpdateAvatar() {
        didUpdateAvatarCalled = true
    }
    
    func logout() {}
}
