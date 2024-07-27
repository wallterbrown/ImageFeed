//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 27.07.2024.
//

import Foundation

final class ImagesListService {
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    private (set) var photos: [Photo] = []
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    private var lastLoadedPage: Int?
    
    
    func fetchPhotosNextPage() {
        guard task == nil else { return }
               
               let nextPage = (lastLoadedPage ?? 0) + 1
               
               guard let request = makePhotosRequest(page: nextPage, perPage: 10) else {
                   print("Failed to make photos request")
                   return
               }
               
               let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
                   guard let self = self else { return }
                   
                   switch result {
                   case .success(let newPhotos):
                      // addToPhotos(newPhotos: newPhotos)
                       NotificationCenter.default.post(
                           name: ImagesListService.didChangeNotification,
                           object: self
                       )
                   case .failure(let error): print(error)
                   }
                   self.task = nil
                   self.lastLoadedPage = nextPage
               }
               self.task = task
               task.resume()
    }
    
    private func makePhotosRequest(page: Int, perPage: Int) -> URLRequest? {
            guard let baseURL = URL(string: Constants.defaultBaseURL) else { return nil }
            guard let token = OAuth2TokenStorage().token else { return nil }
            
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
            components?.path = "/photos"
            
            let queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
            components?.queryItems = queryItems
            
            guard let url = components?.url else { return nil }
            
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            return request
        }
}
