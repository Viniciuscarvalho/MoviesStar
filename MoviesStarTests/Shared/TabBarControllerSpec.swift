import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import MoviesStar

class TabBarControllerSpec: KIFSpec {
    override func spec() {

        var sut: TabBarController!
        
        describe("TabBarController") {
            
            context("when initialized", {
                
                beforeEach {
                    let redViewController = UIViewController()
                    redViewController.view.backgroundColor = .red
                    
                    let blueViewController = UIViewController()
                    blueViewController.view.backgroundColor = .blue
                    
                    sut = TabBarController(moviesViewController: redViewController, favoritesViewController: blueViewController)
                    
                    UIWindow.setTestWindow(rootViewController: sut)
                }
                
                afterEach {
                    UIWindow.cleanTestWindow()
                }
                
                it("should show first tab") {
                    expect(UIWindow.testWindow) == snapshot("TabBarController - First Tab")
                }
                
                it("should show second tab when selected") {
                    tester().tapView(withAccessibilityLabel: "Favorites")
                    expect(UIWindow.testWindow) == snapshot("TabBarController - Second Tab")
                }
            })
            
            context("when created with coder") {
                let sut = TabBarController(coder: NSCoder())
                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }
        }
    }
}
