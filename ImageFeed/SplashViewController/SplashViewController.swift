//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 06.07.2024.
//

import Foundation
import UIKit

final class SplashViewController: UIViewController {
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    
    private let storage = OAuth2TokenStorage.shared
    private let profileService = ProfileService.shared  // Используем синглтон
    private let profileImageService = ProfileImageService.shared
    
    
    private var logoImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(named: "launch-screen-logo")
           imageView.translatesAutoresizingMaskIntoConstraints = false
           return imageView
       }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.ypBlack
            
            // рисуем интерфейс
            addLogoImageView()
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = storage.token {
            fetchProfile(token) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let result):
                    self.fetchProfileImageURL(username: result.username, token: token)
                    self.switchToTabBarController()
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            let storyBoard = UIStoryboard(name: "Main", bundle: .main)
            let authViewController = storyBoard.instantiateViewController(identifier: "AuthViewController") as? AuthViewController
            
            guard let authViewController else { return }
            
            authViewController.delegate = self
            authViewController.modalPresentationStyle = .fullScreen
            
            present(authViewController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func addLogoImageView() {
            view.addSubview(logoImageView)
            
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            logoImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func fetchProfileImageURL(username: String, token: String) {
          profileImageService.fetchProfileImageURL(username: username, token: token) { result in
              switch result {
              case .success(let result):
                  print("fetchProfileImageURL: \(result)")
              case .failure(let error):
                  print(error)
              }
          }
      }
}

extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAuthenticationScreenSegueIdentifier {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else { fatalError("Failed to prepare for \(showAuthenticationScreenSegueIdentifier)") }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func didAuthenticate(_ vc: AuthViewController) {
        vc.dismiss(animated: true)
        if let token = storage.token {
            fetchProfile(token) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(_):
                    //self.fetchProfileImageURL(username: result.username, token: token)
                    self.switchToTabBarController()
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            print("Couldn't read auth token")
        }
    }
    private func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        
        UIBlockingProgressHUD.show()
        
        profileService.fetchProfile(token) { result in
            
            UIBlockingProgressHUD.dismiss()
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        // Обработка кода аутентификации, если нужно
        switchToTabBarController()
    }
}
