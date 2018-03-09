import UIKit

class MoviesAPI {
    
    var client: Client = APIClient()
    private var page: Int = 1
    
    func loadMovies(callback: @escaping (Result<[Movie]>) -> Void) {
        client.request(endpoint: .popular(page: self.page)) { (result) in
            switch result {
            case .success(let data):
                let movieController = MovieController()
                guard let movies = movieController.add(data: data) else {
                    callback(.error(.parseError))
                    return
                }
                self.page += 1
                callback(.success(movies))
            case .error(let error):
                callback(.error(error))
            }
        }
    }
    
    func loadGenres(callback: @escaping (Result<[Genre]>) -> Void) {
        let genreController = GenreController()
        client.request(endpoint: .genre) { (result) in
            switch result {
            case .success(let data):
                guard let genres = genreController.add(data: data) else {
                    callback(.error(.parseError))
                    return
                }
                callback(.success(genres))
            case .error(let error):
                callback(.error(error))
            }
        }
    }
}
