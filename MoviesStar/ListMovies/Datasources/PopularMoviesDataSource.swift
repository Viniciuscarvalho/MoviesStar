import Foundation
import UIKit

class PopularMoviesDataSource: NSObject, DataSourceSearchable {
    
    fileprivate var movies: [Movie]
    fileprivate var selectedMovie: Movie?
    var collectionView: UICollectionView
    
    fileprivate(set) var filteredMovies: [Movie] = []
    var isSearching: Bool = false {
        didSet {
            self.reloadCollection()
        }
    }
    
    init(with movies: [Movie], collectionView: UICollectionView) {
        self.movies = movies
        self.collectionView = collectionView
        super.init()
        self.registerCell()
        self.setupCollectionView()
    }
    
    func registerCell() {
        let nib = UINib(nibName: "PopularMovieCell", bundle: Bundle.main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "PopularMovieCell")
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func addMovies(newMovies: [Movie]) {
        self.movies.append(contentsOf: newMovies)
        self.reloadCollection()
    }
    
    func postNotification() {
        NotificationConstants.shouldLoadMovies.post()
    }
    
    func postItemSelectionNotification() {
        NotificationConstants.shouldHandleItemSelection.post()
    }
    
    func numberOfMovies() -> Int{
        return isSearching ? filteredMovies.count : movies.count
    }
    
    func getSelectedMovie() -> Movie? {
        return self.selectedMovie
    }
    
    func reloadCollection() {
        collectionView.reloadData()
        postCurrentStateNotification()
    }
    
    func getMovie(byIndexPath indexPath: IndexPath) -> Movie {
        let row = indexPath.row
        return isSearching ? filteredMovies[row] : movies[row]
    }
    
    // MARK - DataSourceSearchable protocol
    func filter(withText text: String) {
        self.filteredMovies = movies.filter { $0.title.lowercased().contains(text.lowercased()) }
        self.reloadCollection()
    }
    
    fileprivate func postCurrentStateNotification() {
        NotificationConstants.shouldChangeCurrentState.post()
    }
}

extension PopularMoviesDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.numberOfMovies()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieCell", for: indexPath) as? PopularMovieCell {
            
            let movie = self.getMovie(byIndexPath: indexPath)
            
            cell.setup(movie: movie)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension PopularMoviesDataSource: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 2{
            postNotification()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.getMovie(byIndexPath: indexPath)
        self.selectedMovie = movie
        postItemSelectionNotification()
    }
}

extension PopularMoviesDataSource:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height / 2.5
        let collectionPadding = CGFloat(45)
        let collectionWidth = collectionView.bounds.width - collectionPadding
        let cellWidth = collectionWidth / 2
        
        return CGSize(width: cellWidth, height: cellHeight);
    }
}

