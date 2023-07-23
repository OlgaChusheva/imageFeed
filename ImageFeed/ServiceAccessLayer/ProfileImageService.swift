//
//  ProfileImageServica.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 06.07.2023.
//

import Foundation

final class ProfileImageService {
    
    struct UserResult: Decodable {
        let profileImage: ProfileImage
    }
    struct ProfileImage: Decodable {
        let large: String
    }
    
    static let shared = ProfileImageService()
    private (set) var avatarURL: String?
    private var task: URLSessionTask?
    private var lastUserName: String?
    private var lastToken: String?
    private let urlSession = URLSession.shared
    static let DidChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    func fetchProfileImageURL(
        _ token: String,
        username: String,
        _ completion: @escaping (Result<String, Error>) -> Void) {
            
            assert(Thread.isMainThread)
            
            if (lastUserName == username) || (lastToken == token) { return }
            task?.cancel()
            
            lastUserName = username
            lastToken = token
            
            let request = URLRequest.getRequest(token: token, path: "/users/\(username)")
            let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
                guard let self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        let avatarURLString = image.profileImage.large
                        self.avatarURL = avatarURLString
                        completion(.success(avatarURLString))
                        NotificationCenter.default
                            .post(
                                name: ProfileImageService.DidChangeNotification,
                                object: self,
                                userInfo: ["URL": avatarURLString])
                        self.task = nil
                    case .failure(let error):
                        completion(.failure(error))
                        self.lastUserName = nil
                        self.lastToken = nil
                    }
                }
            }
            self.task = task
            task.resume()
        }
}




