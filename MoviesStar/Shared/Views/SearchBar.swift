import UIKit

protocol DataSourceSearchable {
    var isSearching: Bool {get set}
    var filteredMovies: [Movie] {get}
    
    func filter(withText text: String) -> Void
}

class SearchBar: UISearchBar {
    
    var dataSource: DataSourceSearchable?
    
    init() {
        super.init(frame: .zero)
        delegate = self
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("this class can not be initialized for NSCoder arg")
        return nil
    }
    
    fileprivate func setup() {
        self.barTintColor = UIColor.lightYellow
        self.isTranslucent = false
        self.backgroundImage = UIImage()
        self.returnKeyType = .done
        self.placeholder = "Search"
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.darkYellow
        }
    }
}

extension SearchBar: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.dataSource?.isSearching = false
        } else {
            self.dataSource?.isSearching = true
            self.dataSource?.filter(withText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        self.dataSource?.isSearching = false
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}
