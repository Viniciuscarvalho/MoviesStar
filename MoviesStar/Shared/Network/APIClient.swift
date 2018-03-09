import UIKit

protocol Client {
    func request(endpoint: Endpoints, callback: @escaping (Result<Data>) -> Void)
}

enum APIError: Error {
    case invalidData, parseError, customError(Error)
}

enum Endpoints {
    case popular(page: Int)
    case genre
    
    func description() -> String {
        switch self {
        case .popular:
            return "movie/popular"
        case .genre:
            return "genre/movie/list"
        }
    }
    
    func value() -> String{
        switch self {
        case .popular(let page):
            return "&page=\(page)"
        case .genre:
            return ""
        }
    }
}

class APIClient: Client {
    
    private let baseURL: String = "https://api.themoviedb.org/3/"
    private let apiKey: String = "0527992f02d2f4c4452dbafb51d679d2"
    static let imageBaseURL: String = "https://image.tmdb.org/t/p/w500/"
    
    func request(endpoint: Endpoints, callback: @escaping (Result<Data>) -> Void){
        guard let url = URL(string: "\(baseURL)\(endpoint.description())?api_key=\(apiKey)\(endpoint.value())") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                callback(.error(.customError(error)))
            }
            
            guard let data = data else {
                callback(.error(.invalidData))
                return
            }
            
            callback(.success(data))
        }
        
        task.resume()
    }
}
