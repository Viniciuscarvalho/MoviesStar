import UIKit

class FavoritesDatasource: NSObject {
    
    fileprivate var movies: [Movie]
    var tableView: UITableView
    
    init(with movies: [Movie], tableView: UITableView) {
        self.movies = movies
        self.tableView = tableView
        super.init()
        self.setupTableView()
        self.registerCell()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "FavoritesCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: "FavoritesCell")
    }
    
    private func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func unfavorite(indexPath: IndexPath) {
        let movie = self.movies.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        let movieController = MovieController()
        movieController.remove(id: movie.id)
    }
    
    func update(movies: [Movie]) {
        self.movies = movies
        self.tableView.reloadData()
    }
}

extension FavoritesDatasource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as? FavoritesCell {
            cell.setup(movie: self.movies[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
           self.unfavorite(indexPath: indexPath)
        }
    }
}

extension FavoritesDatasource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
}
