//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Ольга Чушева on 02.07.2023.
//

import Foundation

final class ProfileService {
    static let shared = ProfileService()
    private let urlSession = URLSession.shared
    private (set) var profile: Profile?
    private var task: URLSessionTask?
    private var lastToken: String?
    
    func fetchProfile(_ token: String, completion: @escaping(Result<Profile, Error>) -> Void) {
        
        guard let request = makeFetchProfileRequest() else {
            assertionFailure("Invalid request")
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        //    assert(Thread.isMainThread)
        //  if lastToken == token { return }
        // task?.cancel()
        // lastToken = token
        //    let task = urlSession.dataTask(with: request)  { [weak, self] (result: Result<ProfileResult, Error>);,<#arg#>,<#arg#>  in
        //        guard let self else { return }
        
        //      DispatchQueue.main.async {
        
        currentTask = fetchOAuthBody(request: request){[weak self] response in
            self?.currentTask = nil
            switch response {
            case .success(let body):
                let profile = Profile(profilResult: body)
                self.profile = profile
                completion(.success(profile))
                self.task = nil
            case .failure(let error):
                completion(.failure(error))
                
            }
            
        }
    }
        

        
              
                
                    }
                }
            }
            
            self.task = task
            task.resume()
        }
        private func makeRequest(token: String) -> URLRequest {
            guard let url = URL(string: "https://unsplash.com") else  {fatalError("Failed to create URL")}
            var request = URLRequest(url: url)
            request.httpMethod = "/me"
            return request
        }
        
    }
    
    
    struct ProfileResult: Codable {
        let id: String
        let username: String
        let first_name: String?
        let last_name: String?
        let bio: String?
        let profileImage: ProfileImage?
    }
    
    struct ProfileImage: Codable {
        let small: String?
        let medium: String?
        let large: String?
    }
    
    struct Profile {
        var username: String
        var name: String
        var loginName: String
        var bio: String
        init(profilResult: ProfileResult) {
            self.username = profilResult.username
            self.name = "\(profilResult.first_name ?? "") \(String(describing: profilResult.last_name))"
            self.loginName = "@\(profilResult.username)"
            self.bio = profilResult.bio ?? ""
        }
        
        
        
        
    }
}
