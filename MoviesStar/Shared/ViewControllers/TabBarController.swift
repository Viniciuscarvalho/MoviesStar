import Foundation
import UIKit

final class TabBarController: UITabBarController {
    
    init(moviesViewController: UIViewController, favoritesViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.setupAppearance()
        self.setupTabBarItems(moviesViewController: moviesViewController, favoritesViewController: favoritesViewController)
        self.viewControllers = [moviesViewController, favoritesViewController]
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("this class can not be initialized for NSCoder arg")
        return nil
    }
    
    private func setupTabBarItems(moviesViewController: UIViewController, favoritesViewController: UIViewController) {
        moviesViewController.tabBarItem = UITabBarItem(title: "Movies", image: Assets.list.image, tag: 0)
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: Assets.favoriteEmpty.image, tag: 1)
    }
    
    private func setupAppearance() {
        self.tabBar.barTintColor = UIColor.lightYellow
        self.tabBar.tintColor = .black
    }
    
}
