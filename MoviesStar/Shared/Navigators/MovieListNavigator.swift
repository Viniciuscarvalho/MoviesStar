import UIKit

protocol Navigator {
    associatedtype Destination
    func navigate(to destination: Destination)
}

class MovieListNavigator: Navigator {
    
    enum Destination {
        case itemSelected(movieSource: MovieDetailDataSource)
    }
    
    weak var navigationController: UINavigationController?
    
    func navigate(to destination: Destination) {
        let vc = self.makeViewController(for: destination)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .itemSelected(let movieSource):
            return MovieDetailViewController(dataSource: movieSource)
        }
    }
}
