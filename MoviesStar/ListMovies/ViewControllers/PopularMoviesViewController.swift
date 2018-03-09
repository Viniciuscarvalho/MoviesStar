import Foundation
import UIKit
import SnapKit

class PopularMoviesViewController: UIViewController {

    var noSearchResultsView: ErrorView?
    var popularMovieView: PopularMovieView = PopularMovieView()
    
    enum ViewStates{
        case loading
        case ready
        case error
        case noSearchResults
    }

    var currentState: ViewStates = .loading {
        didSet{
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
                let _ = ErrorView(in: self.view, dismissAfter: 4000)
            case .noSearchResults:
                self.popularMovieView.stopLoading()
                self.noSearchResultsView?.show()
            }
        }
    }
    
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
    
    override func loadView() {
        self.view = self.popularMovieView
        self.noSearchResultsView = ErrorView(in: popularMovieView, errorType: .NoSearchResults, afterView: popularMovieView.searchBar)
    }
    
    override func viewDidLoad() {
        self.setupDelegateAndDataSource()
        self.title = "Movies"
        self.loadGenres()
        self.loadMovies()
        self.setupNotification()
        self.currentState = .loading
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesDataSource?.reloadCollection()
        
    }
    
    fileprivate func setupDelegateAndDataSource() {
        self.moviesDataSource = PopularMoviesDataSource(with: [], collectionView: popularMovieView.collectionView)
        self.popularMovieView.searchBar.dataSource = moviesDataSource
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
                    self.currentState = .ready
                    self.moviesDataSource?.addMovies(newMovies: movies)
                case .error(let error):
                    self.currentState = .error
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
            self.currentState = .noSearchResults
        } else {
            self.currentState = .ready
        }
    }
}
