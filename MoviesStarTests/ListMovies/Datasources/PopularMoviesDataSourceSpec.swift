import Foundation
import Quick
import Nimble

@testable import MoviesStar

class PopularMoviesDataSourceSpec: QuickSpec {
    
    override func spec() {
        
        
        describe("PopularMoviesDataSource") {
            
            context("when created") {
                
                var sut: PopularMoviesDataSource!
                var movies: [Movie]!
                
                beforeEach {
                    let data = LoadJson.loadListResultJson()
                    let movieController = MovieController()
                    movies = movieController.add(data: data)
                    
                    let fakeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
                    sut = PopularMoviesDataSource(with: movies, collectionView: fakeCollectionView)
                }
                
                it("collectionView should not be nil") {
                    expect(sut.collectionView).toNot(beNil())
                }
                
                it("collectionView dataSource should be type PopularMoviesDataSource") {
                    expect(sut.collectionView.dataSource).to(beAKindOf(PopularMoviesDataSource.self))
                }
                
                it("collectionView delegate should be type PopularMoviesDataSource") {
                    expect(sut.collectionView.delegate).to(beAKindOf(PopularMoviesDataSource.self))
                }
                
                it("number of sections should be 1") {
                    expect(sut.collectionView.numberOfSections).to(be(1))
                }
                
                it("number of items in section should be 3") {
                    expect(sut.collectionView.numberOfItems(inSection: 0)).to(be(3))
                }
            }
        
            context("when last cells will be displayed"){
                
                var sut: PopularMoviesDataSourceStub!
                var movies: [Movie]!
                let data = LoadJson.loadListResultJson()
                let movieController = MovieController()
                movies = movieController.add(data: data)
                let fakeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
                sut = PopularMoviesDataSourceStub(with: movies, collectionView: fakeCollectionView)
        
                it("should post the notification on correct displayed cell"){
                    let movieToDisplay = movies.count - 2
                    sut.collectionView.delegate?.collectionView!(sut.collectionView, willDisplay: UICollectionViewCell(), forItemAt: IndexPath(row: movieToDisplay, section: 0))
                    
                    expect(sut.postNotificationCalled).to(beTrue())
                }
                
                it("should not post the notification on incorrect displayed cell"){
                    let movieToDisplay = movies.count - 1
                    sut.collectionView.delegate?.collectionView!(sut.collectionView, willDisplay: UICollectionViewCell(), forItemAt: IndexPath(row: movieToDisplay, section: 0))
                    
                    expect(sut.postNotificationCalled).to(beFalse())
                }
                
                it("should add movies to the data source"){
                    sut.addMovies(newMovies: movies)
                    expect(sut.numberOfMovies()).to(equal(6))
                }
                
                afterEach {
                    sut.postNotificationCalled = false
                }
            }
            
            context("When cell is clicked", {
                var sut: PopularMoviesDataSourceStub!
                var movies: [Movie]!
                let data = LoadJson.loadListResultJson()
                let movieController = MovieController()
                movies = movieController.add(data: data)
                let fakeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
                sut = PopularMoviesDataSourceStub(with: movies, collectionView: fakeCollectionView)
                
                it("should return selected movie", closure: {
                    sut.collectionView.delegate?.collectionView!(sut.collectionView, didSelectItemAt: IndexPath(row: 0, section: 0))
                    expect(sut.getSelectedMovie()).toNot(beNil())
                })
            })
        
            context("when filtering") {
                let fakeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
                let ghost = Movie(id: 1, title: "Ghost", posterPath: nil, releaseDate: "", genreIds: [], overview: "")
                let ironman = Movie(id: 1, title: "Ironman", posterPath: nil, releaseDate: "", genreIds: [], overview: "")
                let movies: [Movie] = [ghost, ironman]
                let sut = PopularMoviesDataSource(with: movies, collectionView: fakeCollectionView)
                
                beforeEach {
                    sut.filter(withText: "ironman")
                    sut.isSearching = true
                }

                it("should filter movie by title") {
                    expect(sut.filteredMovies.count).to(equal(1))
                    expect(sut.filteredMovies[0].title).to(equal("Ironman"))
                }
                
                it("should return movie from filtered movies array") {
                    let movie = sut.getMovie(byIndexPath: IndexPath(row: 0, section: 0))
                    expect(movie.title).to(equal("Ironman"))
                }
                
                it("should return number of filtered movies") {
                    let numberOfMovies = sut.numberOfMovies()
                    expect(numberOfMovies).to(equal(1))
                }
            }
        }
    }
}
