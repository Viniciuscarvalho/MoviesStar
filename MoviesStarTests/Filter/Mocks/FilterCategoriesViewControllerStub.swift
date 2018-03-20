import UIKit
@testable import MoviesStar

class FilterCategoriesViewControllerStub: FilterCategoriesViewController {
    
    var showFilterViewControllerCalled: Bool = false
    var applyButtonTappedCalled: Bool = false
    
    override func showFilterViewController(category: FilterCategory) {
        showFilterViewControllerCalled = true
        super.showFilterViewController(category: category)
    }
    
    override func applyButtonTapped() {
        applyButtonTappedCalled = true
        super.applyButtonTapped()
    }
}
