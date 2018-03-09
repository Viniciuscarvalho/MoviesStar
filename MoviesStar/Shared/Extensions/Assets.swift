import UIKit

enum Assets: String {

    case check = "check_icon"
    case favoriteEmpty = "favorite_empty_icon"
    case favoriteFull = "favorite_full_icon"
    case favoriteGray = "favorite_gray_icon"
    case filter = "filter_icon"
    case list = "list_icon"
    case search = "search_icon"
    case logo = "Splash"

    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
