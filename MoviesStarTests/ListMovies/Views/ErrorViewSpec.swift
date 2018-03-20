import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import MoviesStar

class ErrorViewSpec:QuickSpec {
    
    var sut:ErrorView!
    var containerView:UIView!
    override func spec() {
        
        describe("ErrorViewDefault") {
            context("when generic type of error") {
                beforeEach {
                    self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: 467, height: 800))
                    self.sut = ErrorView(in: self.containerView, dismissAfter: 1000)
                }
                
                it("should have valid snapshot") {
                    expect(self.containerView) == snapshot("ErrorViewDefault")
                }
            }
            
            context("when created with coder") {
                let sut = ErrorView(coder: NSCoder())
                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }
        }
        
        describe("ErrorViewNoResults") {
            context("when have a search error type") {
                beforeEach {
                    self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: 467, height: 800))
                    self.sut = ErrorView(in: self.containerView, errorType: ErrorViewType.NoSearchResults)
                }
                
                it("should have a valid snapshot for search") {
                    expect(self.containerView) == snapshot("ErrorViewNoResults")
                }
            }
        }
        
        describe("ErrorViewNoInternet") {
            context("when have internet error type") {
                beforeEach {
                    self.containerView = UIView(frame: CGRect(x: 0, y: 0, width: 467, height: 800))
                    self.sut = ErrorView(in: self.containerView, errorType: ErrorViewType.NoInternetConnection)
                }
                
                it("should have a valid snapshot for don't have internet") {
                    expect(self.containerView) == snapshot("ErrorViewNoInternet")
                }
            }
        }
    }
}
