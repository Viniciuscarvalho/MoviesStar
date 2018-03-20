import UIKit
import Quick
import Nimble

@testable import MoviesStar

class MovieListNavigatorSpec: QuickSpec {
    
    override func spec() {
        let sut = MovieListNavigator()
        let nvc = MockNavigationController()
        sut.navigationController = nvc
        
        describe("MovieListNavigator") {
            context("when requested to navigate") {
                it("should present movieDetail on itemSelected") {
                    sut.navigate(to: .itemSelected(movieSource: MovieDetailDataSource(genres: [Genre(id: 1, name: "")])))
                    expect(nvc.pushedViewController).to(beAKindOf(MovieDetailViewController.self))
                }
            }
        }
    }
}
