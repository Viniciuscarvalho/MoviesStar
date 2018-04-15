import Foundation
import UIKit
import SnapKit

class PopularMoviesViewController: UIViewController {
    
    var moviesDataSource: PopularMoviesDataSource?
    var detailDataSource: MovieDetailDataSource?
    var api: MoviesAPI = MoviesAPI()
    
    private let navigator: MovieListNavigator
    
    init(navigator: MovieListNavigator) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("this class can not be initialized for NSCoder arg")
        return nil
    }
    
    override func viewDidLoad() {
        self.setupDelegateAndDataSource()
        self.title = "Movies"
        self.loadGenres()
        self.loadMovies()
        self.setupNotification()
    }
    
    override func loadView() {
        self.presenter = self.presenter.popularMovieView
        self.view = presenter.popularMovieView
        self.presenter.noSearchResultsView = ErrorView(in: presenter.popularMovieView,
                                                       errorType: .NoSearchResults,
                                                       afterView: presenter.popularMovieView.searchBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesDataSource?.reloadCollection()
    }
    
    fileprivate func setupDelegateAndDataSource() {
        self.moviesDataSource = PopularMoviesDataSource(with: [], collectionView: presenter.popularMovieView.collectionView)
        self.presenter.popularMovieView.searchBar.dataSource = moviesDataSource
    }
    
    fileprivate func setupNotification() {
        NotificationConstants.shouldLoadMovies.observe(target: self, selector: #selector(loadMovies))
        NotificationConstants.shouldHandleItemSelection.observe(target: self, selector: #selector(handleItemSelection))
        NotificationConstants.shouldChangeCurrentState.observe(target: self, selector: #selector(changeCurrenteState))
    }
    
    fileprivate func loadGenres(){
        let genreController = GenreController()
        api.loadGenres { (result) in
            switch result {
            case .success(let genres):
                self.detailDataSource = MovieDetailDataSource(genres: genres)
                genreController.save(genres: genres)
            case .error(let error):
                switch error {
                case .customError(let error):
                    print("A custom error ocurred on loadGenres: \(error)")
                case .invalidData:
                    print("Received invalid data on loadGenres")
                case .parseError:
                    print("Parse error on loadGenres")
                }
            }
        }
    }
    
    @objc func loadMovies() {
        api.loadMovies { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.presenter.currentState = .ready
                    self.moviesDataSource?.addMovies(newMovies: movies)
                case .error(let error):
                    self.presenter.currentState = .error
                    switch error {
                    case .customError(let error):
                        print("A custom error ocurred on loadMovies: \(error)")
                    case .invalidData:
                        print("Received invalid data on loadMovies")
                    case .parseError:
                        print("Parse error on loadMovies")
                    }
                }
            }
        }
    }
    
    @objc func handleItemSelection() {
        if let movie = self.moviesDataSource?.getSelectedMovie(),
            let dataSource = self.detailDataSource {
            dataSource.movie = movie
            navigator.navigate(to: .itemSelected(movieSource: dataSource))
        }
    }
    
    @objc func changeCurrenteState() {
        if self.moviesDataSource?.isSearching == true, self.moviesDataSource?.filteredMovies.count == 0 {
            self.presenter.currentState = .noSearchResults
        } else {
            self.presenter.currentState = .ready
        }
    }
}
