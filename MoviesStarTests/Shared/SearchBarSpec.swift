import Quick
import Nimble
@testable import MoviesStar

class SearchBarSpec: QuickSpec {
    
    override func spec() {
        
        describe("SearchBar") {
            
            let dataSourceSearchable = DataSourceSearchableStub()
            let vc = PopularMoviesViewController(navigator: MovieListNavigator())
            let sut = vc.popularMovieView.searchBar
            sut.dataSource = dataSourceSearchable
            
            context("when seachBar is instanciated", {
                
                it("should return configurated Search bar", closure: {
                    expect(sut).toNot(beNil())
                })
                
            })
            
            context("when text bigin editing", {
                
                it("cancel button should be presented", closure: {
                    expect(sut.searchBarShouldBeginEditing(sut)).to(beTrue())
                    expect(sut.showsCancelButton).to(beTrue())
                })
                
            })
            
            context("when Done button was clicked", {
                it("search bar should not be first responder", closure: {
                    sut.searchBarSearchButtonClicked(sut)
                    expect(sut.isFirstResponder).to(beFalse())
                })
            })
            
            context("when cancel button was clicked", {
                it("search bar should not be first responder", closure: {
                    sut.searchBarCancelButtonClicked(sut)
                    expect(sut.isFirstResponder).to(beFalse())
                })
                
                it("should change value for isSearching param", closure: {
                    sut.searchBarCancelButtonClicked(sut)
                    expect(sut.dataSource?.isSearching).to(beFalse())
                })
            })
            
            context("when text did begin editing", {
                it("should change value for isSearching param", closure: {
                    sut.searchBar(sut, textDidChange: "test movie")
                    expect(sut.dataSource?.isSearching).to(beTrue())
                })
                
                it("filtered array should contains search text", closure: {
                    let movieTitle = "test movie"
                    sut.searchBar(sut, textDidChange: movieTitle)
                    let movieFiltered = sut.dataSource?.filteredMovies.first!
                    expect(movieFiltered?.title.contains(movieTitle)).to(beTrue())
                })
            })
            
            context("when created with coder") {
                let sut = SearchBar(coder: NSCoder())
                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }
        }
    }
}
