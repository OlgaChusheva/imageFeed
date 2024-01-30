import Foundation


final class ProfileService {
    
    static let shared = ProfileService()
    private (set) var profile: Profile?
    private var task: URLSessionTask?
    
    func clean() {
        profile = nil
        task?.cancel()
        task = nil
    }
}

extension ProfileService {
    
    public func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        
        //Логика для предотвращения гонки
        assert(Thread.isMainThread)
        task?.cancel()
        
        //Формирование URLRequest на получение данных своего профиля
        guard let request = fetchProfileRequest(token) else { return }
        
        //создание URLSessionDataTask на получение данных своего профиля
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self = self else { return }
            self.task = nil
            switch result {
            case .success(let profileResult):
                self.profile = Profile(userName: profileResult.userName ?? "",
                                       name: "\(profileResult.firstName ?? "") " + "\(profileResult.lastName ?? "")",
                                       loginName: "@\(profileResult.userName ?? "")" ,
                                       bio: profileResult.bio ?? "")
                completion(.success(self.profile!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        self.task = task
        task?.resume()
    }
    
    private func fetchProfileRequest(_ token: String) -> URLRequest? {
        var request = URLRequest.makeHTTPRequest(
            path: "/me",
            httpMethod: "GET",
            baseURL: AuthConfiguration.standart.defaultBaseURL)
        request?.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}


        
                                        
                                        
     
                
            
            
            
            //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
