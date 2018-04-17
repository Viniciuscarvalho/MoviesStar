import UIKit

enum FilterCategory: String {
    case date, genre
    
    var title: String {
        switch self {
        case .date:
            return "Date"
        case .genre:
            return "Genres"
        }
    }
}

class FilterCategoriesViewController: UIViewController {
    
    fileprivate(set) var categories: [FilterCategory] = [.date, .genre]
    fileprivate(set) var filterView: FilterView?
    fileprivate var yearDataSource: BaseFilterDataSource?
    fileprivate var genreDataSource: BaseFilterDataSource?
    fileprivate var movieController: MovieController
    fileprivate var genreController: GenreController
    
    init() {
        self.movieController = MovieController()
        self.genreController = GenreController()
        super.init(nibName: nil, bundle: nil)
        setupView()
        fetchYears()
        fetchGenres()
    }
    
    fileprivate func setupView() {
        self.filterView = FilterView(tableViewDataSource: self, tableViewDelegate: self, target: self, applyButtonSelector: #selector(applyButtonTapped))
        self.view = self.filterView
        navigationItem.title = "Filter"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.filterView?.tableView.reloadData()
    }
    
    @objc func applyButtonTapped() {
        postNotification()
        backToFavoritesViewController()
    }
    
    fileprivate func postNotification() {
        let items = getFilterInfo()
        NotificationConstants.shouldApplyCustomFilter.post(withDictionary: items)
    }
    
    fileprivate func backToFavoritesViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func getFilterInfo() -> [String: Any] {
        var items: [String: Any] = [:]
        if let year = self.yearDataSource?.dataSource.selectedItem {
            items[FilterCategory.date.rawValue] = year
        }
        
        if let genre = self.genreDataSource?.dataSource.selectedItem {
            items[FilterCategory.genre.rawValue] = genre
        }
        return items
    }
    
    fileprivate func fetchYears() {
        let years = self.movieController.fetchWithoutDuplicateYears()
        buildDataSource(toCategory: .date, items: years)
    }
    
    fileprivate func fetchGenres() {
        let genresEntity = self.genreController.fetchAll()
        var genres: [String] = []
        _ = genresEntity.map { genres.append($0.name) }
        buildDataSource(toCategory: .genre, items: genres)
    }
    
    fileprivate func buildDataSource(toCategory category: FilterCategory, items: [String]) {
        switch category {
        case .date:
            self.yearDataSource = BaseFilterDataSource()
            self.yearDataSource?.dataSource.items = items
        case .genre:
            self.genreDataSource = BaseFilterDataSource()
            self.genreDataSource?.dataSource.items = items
        }
    }
    
    func showFilterViewController(category: FilterCategory) {
        if let yearDataSource = self.yearDataSource, let genreDataSource = self.genreDataSource {
            var filterViewController: FilterViewController
            switch category {
            case .date:
                filterViewController = FilterViewController(tableViewDataSource: yearDataSource)
            case .genre:
                filterViewController = FilterViewController(tableViewDataSource: genreDataSource)
            }
            
            self.navigationController?.pushViewController(filterViewController, animated: true)
        }
    }
}

extension FilterCategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.identifier, for: indexPath) as? BasicTableViewCell else {
            fatalError("Cell should be a instance of BasicTableViewCell")
        }
        
        let category = categories[indexPath.row]
        let customInfo = getCustomInfo(byCategory: category)
        cell.configure(text: category.title, customInfo: customInfo)
        
        return cell
    }
    
    func getCustomInfo(byCategory category: FilterCategory) -> String? {
        switch category {
        case .date:
            return self.yearDataSource?.dataSource.selectedItem
        case .genre:
            return self.genreDataSource?.dataSource.selectedItem
        }
    }
}

extension FilterCategoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let category = categories[indexPath.row]
        showFilterViewController(category: category)
    }
}
