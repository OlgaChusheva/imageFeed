//
//  ImageListService.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 13.11.2023.
//

import Foundation

final class ImagesListService {
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    static let shared = ImagesListService()
    private (set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private let perPage = "10"
    private var task: URLSessionTask?
    
    private let dateFormatter = ISO8601DateFormatter()
    
    func updatePhotos(_ photos: [Photo]) {
        self.photos = photos
    }
    
    func clean() {
        photos = []
        lastLoadedPage = nil
        task?.cancel()
        task = nil
    }
}
    
extension ImagesListService {
    
    func fetchPhotosNextPage() {
        //Предотвращения гонки
        assert(Thread.isMainThread)
        guard task == nil else { return }
        
        let page = lastLoadedPage == nil ? 1 : lastLoadedPage! + 1
        guard let token = OAuth2TokenStorage().token else { return }
        
        //URLRequest на получение картинок
        guard let request = fetchImagesListRequest(token, page: String(page), perPage: perPage) else { return }
        
        //создание URLSessionDataTask на получение картинок
        
//        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                self.task = nil
//                switch result {
//                case .success(let photoResults):
//                    for photoResult in photoResults {
//                        self.photos.append(self.convert(photoResult))
//                    }
//                    self.lastLoadedPage = page
//                    NotificationCenter.default
//                        .post(
//                            name: ImagesListService.didChangeNotification,
//                            object: self,
//                            userInfo: ["Images" : self.photos])
//                case .failure(let error):
//                    assertionFailure("Ошибка получения изображений \(error)")
//                }
//            }
//        }
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            assert(Thread.isMainThread)
            
            switch result {
            case .success(let photoResults):
                for photoResult in photoResults {
                                        self.photos.append(self.convert(photoResult))
                                    }
                NotificationCenter.default
                                       .post(
                                           name: ImagesListService.didChangeNotification,
                                           object: self,
                                           userInfo: ["Images" : self.photos])
            case .failure(let error):
                if error.localizedDescription != "cancelled" {
                    
                }
            }
   //         self.photosTask = nil
        }
                    
        self.task = task
        task?.resume()
    }
    
    private func convert(_ photoResult: PhotoResult) -> Photo {
       
        let date = dateFormatter.date(from:photoResult.createdAt ?? "")
        return Photo.init(id: photoResult.id,
                          size: CGSize(width: photoResult.width ?? 0, height: photoResult.height ?? 0),
                          createdAt: date,
                          welcomeDescription: photoResult.welcomeDescription,
                          thumbImageURL: photoResult.urls?.thumbImageURL,
                          largeImageURL: photoResult.urls?.largeImageURL,
                          isLiked: photoResult.isLiked ?? false)
    }
    
    private func fetchImagesListRequest(_ token: String, page: String, perPage: String) -> URLRequest? {
        var request = URLRequest.makeHTTPRequest(
            path: "/photos?page=\(page)&&per_page=\(perPage)",
            httpMethod: "GET",
            baseURL: AuthConfiguration.standart.defaultBaseURL)
        request?.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        //Логика для предотвращения гонки
        assert(Thread.isMainThread)
        task?.cancel()
        
        guard let token = OAuth2TokenStorage().token else { return }
   
        //Формирование URLRequest на получение картинок
        
        var request: URLRequest?
        if isLike {
            request = deleteLikeRequest(token, photoId: photoId)
        } else {
            request = postLikeRequest(token, photoId: photoId)
        }
        guard let request = request else { return }
        
     
        //создание URLSessionDataTask для проставления лайка
        
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<LikePhotoResult, Error>) in
            guard let self = self else { return }
            self.task = nil
            switch result {
            case .success(let photoResult):
                let isLiked = photoResult.photo?.isLiked ?? false
                if let index = self.photos.firstIndex(where: { $0.id == photoResult.photo?.id }) {
                    // Текущий элемент
                    var photo = self.photos[index]
                    photo.isLiked = isLiked
                    // Заменяем элемент в массиве
                    self.photos = self.photos.withReplaced(itemAt: index, newValue: photo)
                }
                print("isLiked = \(String(describing: isLiked))")
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        self.task = task
        task?.resume()
    }
    
    private func postLikeRequest(_ token: String, photoId: String) -> URLRequest? {
        //POST /photos/:id/like
        var requestPost = URLRequest.makeHTTPRequest(
            path: "photos/\(photoId)/like",
            httpMethod: "POST",
            baseURL: AuthConfiguration.standart.defaultBaseURL)
        requestPost?.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return requestPost
    }
    
    private func deleteLikeRequest(_ token: String, photoId: String) -> URLRequest? {
        //DELETE /photos/:id/like
        var requestDelete = URLRequest.makeHTTPRequest(
            path: "photos/\(photoId)/like",
            httpMethod: "DELETE",
            baseURL: AuthConfiguration.standart.defaultBaseURL)
        requestDelete?.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return requestDelete
    }
}
    



