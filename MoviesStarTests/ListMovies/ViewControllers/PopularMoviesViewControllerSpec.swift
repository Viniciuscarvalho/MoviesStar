import UIKit
import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesStar

class PopularMoviesViewControllerSpec: QuickSpec {
    
    var sut: PopularMoviesViewController!
    
    override func spec() {
        describe("PopularMoviesViewController") {
            
            context("verify view states") {
                
                beforeEach {
                    self.sut = PopularMoviesViewController(navigator: MovieListNavigator())
                    UIWindow.setTestWindow(rootViewController: self.sut)
                }
                
                afterEach {
                    UIWindow.cleanTestWindow()
                }
                
                it("should show error view") {
                    self.sut.currentState = .error
                    expect(UIWindow.testWindow) == snapshot("PopularMoviesViewController - Error")
                }
                
                it("should show loading view") {
                    self.sut.currentState = .loading
                    expect(UIWindow.testWindow) == snapshot("PopularMoviesViewController - Loading")
                }
                
                it("should show ready view") {
                    self.sut.currentState = .ready
                    expect(UIWindow.testWindow) == snapshot("PopularMoviesViewController - Ready")
                }
                
                it("should show no search results view") {
                    self.sut.currentState = .noSearchResults
                    expect(UIWindow.testWindow) == snapshot("PopularMoviesViewController - NoSearchResults")
                }
            }
        
            context("handling collection view selection") {
                let sut = PopularMoviesViewController(navigator: MovieListNavigator())
                beforeEach {
                    sut.api.client = APIClientMock()
                    sut.detailDataSource = MovieDetailDataSource(genres: [Genre(id: 1, name: "")])
                    sut.viewDidLoad()
                    let movie = Movie(id: 1, title: "Ghost", posterPath: nil, releaseDate: "", genreIds: [], overview: "")
                    sut.moviesDataSource?.addMovies(newMovies: [movie])
                }
                
                it("should assert selected movie to detailDataSource") {
                    sut.moviesDataSource?.collectionView.delegate?.collectionView!(sut.moviesDataSource!.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
                    sut.handleItemSelection()
                    expect(sut.detailDataSource?.movie?.title).to(equal("Ghost"))
                }
            }
            
            context("handling change of state") {
                beforeEach {
                    self.sut = PopularMoviesViewController(navigator: MovieListNavigator())
                    self.sut.viewDidLoad()
                    self.sut.moviesDataSource?.isSearching = true
                }
                
                it("should change to no search results on empty filtered arrays") {
                    self.sut.changeCurrenteState()
                    switch self.sut.currentState{
                    case .noSearchResults:
                        expect(true).to(beTrue())
                    default:
                        expect(false).to(beFalse())
                    }
                }
            }
            
            context("when created with coder") {
                let sut = PopularMoviesViewController(coder: NSCoder())
                
                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }
        }
    }
}

