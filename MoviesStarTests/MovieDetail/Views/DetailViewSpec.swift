import Quick
import Nimble
import Nimble_Snapshots

@testable import MoviesStar

class DetailViewSpec: QuickSpec {
    
    var sut: DetailView!
    var superView: UIView!
    
    @objc func selectorFuncTest() {}
    
    override func spec() {
        
        describe("DetailView") {
            
            beforeEach {
                self.superView = UIView(frame: CGRect(x: 0, y: 0, width: 467, height: 800))
                self.sut = DetailView(superView: self.superView, target: self, favoriteButtonSelector: #selector(self.selectorFuncTest))
            }
            
            context("when view is create", {
                
                let data = LoadJson.loadListResultJson()
                let movieController = MovieController()
                let movies = movieController.add(data: data)
                let movie = movies?.first
                let genres = [
                    Genre(id: 14, name: "Drama"),
                    Genre(id: 28, name: "Adventure"),
                    Genre(id: 80, name: "Terror")
                ]
                let dataSource = MovieDetailDataSource(genres: genres)
                dataSource.movie = movie
            
                it("should create DetailView", closure: {
                    expect(self.sut).toNot(beNil())
                })
                
                it("should load view", closure: {
                    self.sut.configureView(dataSource: dataSource)
                    expect(self.superView) == snapshot("DetailView")
                })
            })
            
            context("when created with coder") {
                let sut = DetailView(coder: NSCoder())
                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }
        }
    }
}
