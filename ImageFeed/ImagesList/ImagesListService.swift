//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Albina Musugalieva on 20.04.2026.
//

import UIKit

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
}

struct PhotoResult: Codable {
    let id: String
    let width: Int
    let height: Int
    let createdAt: String?
    let description: String?
    let urls: UrlsResult
    var isLiked: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case createdAt = "created_at"
        case description
        case urls
        case isLiked = "liked_by_user"
    }
}

struct UrlsResult: Codable{
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

final class ImagesListService{
    static let shared = ImagesListService()
    private let urlSession = URLSession.shared
    private let tokenStorage = OAuth2TokenStorage.shared
    private lazy var isoFormatter = ISO8601DateFormatter()
    private var task: URLSessionTask?
    private(set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    static let didChangeNotification = Notification.Name("ImagesListServiceDidChange")
    
    private init(){}
    
    func fetchPhotosNextPage () {
       guard task == nil else {return}
        let nextPage = (lastLoadedPage ?? 0) + 1
        
        guard let token = tokenStorage.token, let request = makeImagesListRequest(page: nextPage, token: token) else {
            return
        }
    
        task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self else { return }
            switch result {
            case .success(let photoResults):
                let isoFormatter = self.isoFormatter
                let newPhotos = photoResults.map { result in
                    let date = result.createdAt.flatMap {
                        isoFormatter.date(from: $0)
                    }
                    return Photo(
                        id: result.id,
                        size: CGSize(width: result.width, height: result.height),
                        createdAt: date,
                        welcomeDescription: result.description,
                        thumbImageURL: result.urls.thumb,
                        largeImageURL: result.urls.full,
                        isLiked: result.isLiked
                    )
                }
                DispatchQueue.main.async {
                    self.photos.append(contentsOf: newPhotos)
                    self.lastLoadedPage = nextPage
                    NotificationCenter.default.post(name: ImagesListService.didChangeNotification, object: self)
                }
            case .failure:
                    print("Failure to load photos in ImagesListService")
                 
            }
            self.task = nil
        }
        task?.resume()
        
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        guard task == nil else {return}
        
        guard let token = tokenStorage.token, let request = makeChangeLikeRequest(photoId: photoId, isLike: isLike, token: token) else {
            return
        }
      
        task = urlSession.data(for: request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                if let index = self.photos.firstIndex(where: { $0.id == photoId }) {
                   let photo = self.photos[index]
                   let newPhoto = Photo(
                            id: photo.id,
                            size: photo.size,
                            createdAt: photo.createdAt,
                            welcomeDescription: photo.welcomeDescription,
                            thumbImageURL: photo.thumbImageURL,
                            largeImageURL: photo.largeImageURL,
                            isLiked: !photo.isLiked
                        )
                    DispatchQueue.main.async {
                        self.photos[index] = newPhoto
                        completion(.success(()))
                    }
                }
            case .failure(let error):
                    print("Failure to changeLike in ImagesListService")
                completion(.failure(error))
                 
            }
            self.task = nil
        }
        task?.resume()
        
    }
    
    func logout(){
        photos = []
        task = nil
        lastLoadedPage = nil
    }
    
    private func makeImagesListRequest(page: Int, token: String) -> URLRequest? {
        var urlComponents = URLComponents(string: Constants.defaultBaseURLString + "/photos")
        urlComponents?.queryItems = [URLQueryItem(name: "page", value: String(page))]
                
        guard let url = urlComponents?.url else { return nil }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func makeChangeLikeRequest(photoId: String, isLike: Bool, token: String) -> URLRequest?{
        guard let url = URL(string: Constants.defaultBaseURLString + "/photos/" + photoId + "/like") else { return nil }
        
        var request = URLRequest(url: url)
        if isLike{
            request.httpMethod = HTTPMethod.post.rawValue
        } else {
            request.httpMethod = HTTPMethod.delete.rawValue
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}
