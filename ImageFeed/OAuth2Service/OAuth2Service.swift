//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 02.07.2024.
//

import Foundation

enum AuthServiceError: Error {
    case invalidRequest
}

final class OAuth2Service {
    static let shared = OAuth2Service()
    
    private let oAuth2TokenStorage = OAuth2TokenStorage.shared
    private let urlSession = URLSession.shared
    private var currentTask: URLSessionTask?
    private var currentCode: String?
    
    private init() {}
    
    func fetchOAuthToken(code: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        guard currentCode != code else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        
        currentTask?.cancel()
        currentCode = code
        
        guard let request = makeOAuthTokenRequest(code: code) else {
            completion(.failure(AuthServiceError.invalidRequest))
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponse, Error>) in
            switch result {
            case .success(let data):
                let tokenStorage = OAuth2TokenStorage.shared
                tokenStorage.token = data.accessToken
                completion(.success(nil))
            case .failure(let error): completion(.failure(error))
            }
            self?.currentTask = nil
            self?.currentCode = nil
        }
        self.currentTask = task
        task.resume()
    }
    
    private func makeOAuthTokenRequest(code: String) -> URLRequest? {
        guard let baseURL = URL(string: "https://unsplash.com") else { return nil }
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.path = "/oauth/token"
        
        let queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_secret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        components?.queryItems = queryItems
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        return request
    }
}
