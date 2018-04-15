import Foundation

protocol PopularMoviesPresenter {
    
    func showLoading()
    func hideLoading()
    func showMovies(movies: [Movie])
    func showError()
    func showEmptySearchResults()
    
}

