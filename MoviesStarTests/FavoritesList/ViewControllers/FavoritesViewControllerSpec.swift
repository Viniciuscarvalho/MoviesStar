import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesStar

class FavoritesViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("FavoritesViewController") {

            context("when created") {
                let sut = FavoritesViewController()
                
                it("should assert view type to FavoritesView") {
                    expect(sut.view).to(beAKindOf(FavoritesView.self))
                }
                
                it("should configure FavoritesDataSource") {
                    expect(sut.favoritesView).toNot(beNil())
                }
            }
            
            context("when appears") {
                
                var sut: FavoritesViewController!
                var dataSourceStub: FavoritesDatasourceStub!
                
                beforeEach {
                    sut = FavoritesViewController()
                    dataSourceStub = FavoritesDatasourceStub(with: [], tableView: UITableView(frame: .zero))
                    sut.favoritesDatasource = dataSourceStub
                    dataSourceStub.updateDatasourceCalled = false
                }

                it("should update the datasource") {
                    sut.viewWillAppear(false)
                    expect(dataSourceStub.updateDatasourceCalled).to(beTrue())
                }
                
                it("should not update with data source as nil") {
                    sut.favoritesDatasource = nil
                    sut.viewWillAppear(false)
                    expect(dataSourceStub.updateDatasourceCalled).to(beFalse())
                }
            }
        
            context("when UI is loaded") {
                beforeEach {
                    let sut = FavoritesViewController()
                    UIWindow.setTestWindow(rootViewController: sut)
                    let movie = Movie(id: 1, title: "Lorem", posterPath: nil, releaseDate: "", genreIds: [1], overview: "Lorem Ipsum")
                    sut.favoritesDatasource?.update(movies: [movie, movie, movie])
                }
                
                afterEach {
                    UIWindow.cleanTestWindow()
                }
                
                it("should have a valid snapshot") {
                    expect(UIWindow.testWindow) == snapshot("FavoritesViewController")
                }
            }
        }
    }
}
