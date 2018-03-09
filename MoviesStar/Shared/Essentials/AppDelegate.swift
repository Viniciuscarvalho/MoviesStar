import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let movieListNavigator = MovieListNavigator()
        let popularMoviesViewController = PopularMoviesViewController(navigator: movieListNavigator)
        let popularMoviesNavigationController = NavigationController(rootViewController: popularMoviesViewController)
        movieListNavigator.navigationController = popularMoviesNavigationController
        
        let favoriteMoviesViewController = FavoritesViewController()
        let favoriteMoviesNavigationController = NavigationController(rootViewController: favoriteMoviesViewController)
        
        let tabBarController = TabBarController(moviesViewController: popularMoviesNavigationController, favoritesViewController: favoriteMoviesNavigationController)
        
        self.window?.rootViewController = tabBarController
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "moviesstar")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

