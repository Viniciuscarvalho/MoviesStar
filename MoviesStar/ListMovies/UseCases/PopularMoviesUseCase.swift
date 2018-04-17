import Foundation

public class PopularMoviesUseCase {
    
    private var presenter: PopularMoviesPresenter
    private var service: MoviesAPI
    
    init(presenter: PopularMoviesPresenter, service: MoviesAPI) {
        self.presenter = presenter
        self.service = service
    }
    
    public func list() {
        service.loadMovies { movies, error in
            if let movies = movies {
                self.presenter.showMovies(movies: movies)
            } else if let error = error {
                self.presenter.showError()
            }
        }
    }
    
}
