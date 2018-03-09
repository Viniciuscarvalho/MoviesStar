import UIKit

class FavoritesViewController: UIViewController {
    
    var favoritesView: FavoritesView = FavoritesView(target: self, removeFilterSelector: #selector(hideButtonRemoveFilter))
    var favoritesDatasource: FavoritesDatasource?
    fileprivate var movieController = MovieController()
    fileprivate var filteredYear: String?
    fileprivate var filteredGenre: String?
    fileprivate var isFiltering: Bool = false {
        didSet{
            changeFilterState()
        }
    }
    
    override func loadView() {
        self.view = self.favoritesView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateDatasource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        self.setupDatasource()
        self.setupNavigationItem()
        self.setupNotifications()
    }
    
    func updateDatasource() {
        guard let dataSource = favoritesDatasource else {return}
        var movies = [Movie]()
        if isFiltering {
            if let genre = self.filteredGenre, let year = self.filteredYear {
                movies = self.movieController.fetch(byGenreName: genre, andYear: year)
            } else {
                if let genre = self.filteredGenre  {
                    movies = self.movieController.fetch(byGenreNames: [genre])
                }
                
                if let year = self.filteredYear {
                    movies = self.movieController.fetch(byYear: year)
                }
            }
        } else {
            movies = self.movieController.fetchAll()
        }
        
        dataSource.update(movies: movies)
    }
    
    fileprivate func setupDatasource() {
        self.favoritesDatasource = FavoritesDatasource(with: [], tableView: favoritesView.tableView)
    }
    
    fileprivate func setupNavigationItem() {
        let barButton = FilterButton(target: self, selector: #selector(filterButtonTapped))
        let bar = UIBarButtonItem(customView: barButton)
        navigationItem.setRightBarButton(bar, animated: false)
    }
    
    fileprivate func setupNotifications() {
        NotificationConstants.shouldApplyCustomFilter.observe(target: self, selector: #selector(applyCusomFilter(_:)))
    }
    
    fileprivate func changeFilterState() {
        if isFiltering {
            self.favoritesView.showRemoveFilterButton()
        } else {
            self.favoritesView.hideRemoveFilterButton()
            clearFilterParams()
        }
        
        self.updateDatasource()
    }
    
    @objc fileprivate func filterButtonTapped() {
        let filterCategoriesViewController = FilterCategoriesViewController()
        self.navigationController?.pushViewController(filterCategoriesViewController, animated: true)
    }
    
    @objc fileprivate func applyCusomFilter(_ notification: NSNotification) {
        clearFilterParams()
        
        if let year = notification.userInfo?[FilterCategory.date.rawValue] as? String {
            self.filteredYear = year
        }
        
        if let genre = notification.userInfo?[FilterCategory.genre.rawValue] as? String {
            self.filteredGenre = genre
        }
        
        self.isFiltering = true
    }
    
    @objc func hideButtonRemoveFilter() {
        self.isFiltering = false
    }
    
    fileprivate func clearFilterParams() {
        self.filteredGenre = nil
        self.filteredYear = nil
    }
}
