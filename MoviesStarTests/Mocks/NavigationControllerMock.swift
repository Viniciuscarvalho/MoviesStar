import UIKit
import Quick
import Nimble

@testable import MoviesStar

class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    internal override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
    }
}
