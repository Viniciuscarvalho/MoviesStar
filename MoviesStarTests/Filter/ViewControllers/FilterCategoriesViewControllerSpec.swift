import UIKit
import Quick
import Nimble
import Nimble_Snapshots
@testable import MoviesStar

class FilterCategoriesViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("FilterCategoriesViewControllerSpec") {
            let sut = FilterCategoriesViewControllerStub()
            
            context("when view controlles is instantiated", {
                
                it("should not be nil", closure: {
                    expect(sut).toNot(beNil())
                })
                
                it("categories should not be nil", closure: {
                    expect(sut.categories.count).to(equal(2))
                })
            })
            
            context("when tableView is instantiated", {
                
                it("should not be nil", closure: {
                    expect(sut.filterView?.tableView).toNot(beNil())
                })
                
                it("should return number of rows", closure: {
                    expect(sut.filterView?.tableView.numberOfRows(inSection: 0)).to(equal(2))
                })
                
                it("should instantiate BasicTableViewCell", closure: {
                    let indexPath = IndexPath(row: 0, section: 0)
                    let cell = sut.tableView((sut.filterView?.tableView)!, cellForRowAt: indexPath)
                    
                    expect(cell.isKind(of: BasicTableViewCell.self)).to(beTrue())
                })
            })
            
            context("when item is selected", {
                
                it("should present FilterViewController", closure: {
                    let indexPath = IndexPath(row: 0, section: 0)
                    sut.tableView((sut.filterView?.tableView)!, didSelectRowAt: indexPath)
                    expect(sut.showFilterViewControllerCalled).to(beTrue())
                })
            })
            
            context("when apply button tapped", {
                
                it("should call applyButtonTapped", closure: {
                    sut.applyButtonTapped()
                    expect(sut.applyButtonTappedCalled).to(beTrue())
                })
            })
            
            context("when UI is Loads", {
                
                beforeEach {
                    let sut = FilterCategoriesViewController()
                    UIWindow.setTestWindow(rootViewController: sut)
                }
                
                afterEach {
                    UIWindow.cleanTestWindow()
                }
                
                it("should initialize UI", closure: {
                    expect(UIWindow.testWindow) == snapshot("FilterCategoriesViewController")
                })
            })
        }
    }
}
