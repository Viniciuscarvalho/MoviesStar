import Foundation
import UIKit

class PopularMoviesPresenter {
    
    func showLoading()
    func hideLoading()
    func show()
    func showError()
    func showEmptySearchResults()
    
    var currentState: ViewStatesMoviesPresenter = .loading
    
    func displayStates(_ currentState: ViewStatesMoviesPresenter) {
        
        switch currentState {
        case .loading:
            self.popularMovieView.startLoading()
            self.noSearchResultsView?.hide()
        case .ready:
            self.popularMovieView.stopLoading()
            self.noSearchResultsView?.hide()
        case .error:
            self.popularMovieView.stopLoading()
            self.noSearchResultsView?.hide()
            let _ = ErrorView(in: popularMovieView, dismissAfter: 4000)
        case .noSearchResults:
            self.popularMovieView.stopLoading()
            self.noSearchResultsView?.show()
        }
    }
}

