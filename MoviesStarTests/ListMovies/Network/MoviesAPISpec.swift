import Foundation
import Quick
import Nimble

@testable import MoviesStar

class MoviesAPISpec: QuickSpec{
    
    override func spec(){
        describe("MoviesAPI"){
            let sut = MoviesAPI()
            let apiClientMock = APIClientMock()
            sut.client = apiClientMock
            
            context("when requested to load movies"){
            
                it("should callback data on success request"){
                    apiClientMock.testCase = .success
                    sut.loadMovies(callback: { (result) in
                        switch result{
                        case .success:
                            expect(true).to(beTrue())
                        default:
                            expect(false).to(beTrue())
                        }
                    })
                }
                
                it("should callback nil on request error"){
                    apiClientMock.testCase = .error
                    sut.loadMovies(callback: { (result) in
                        switch result{
                        case .error:
                            expect(true).to(beTrue())
                        default:
                            expect(false).to(beTrue())
                        }
                    })
                }
                
                it("should return nil on parse error"){
                    apiClientMock.testCase = .parseError
                    sut.loadMovies(callback: { (result) in
                        switch result{
                        case .error:
                            expect(true).to(beTrue())
                        default:
                            expect(false).to(beTrue())
                        }
                    })
                }
            }
        
            context("when requested to load genres"){
                it("should callback data on success request"){
                    apiClientMock.testCase = .success
                    sut.loadGenres(callback: { (result) in
                        switch result{
                        case .success:
                            expect(true).to(beTrue())
                        default:
                            expect(false).to(beTrue())
                        }
                    })
                }
                
                it("should callback nil on request error"){
                    apiClientMock.testCase = .error
                    sut.loadGenres(callback: { (result) in
                        switch result{
                        case .error:
                            expect(true).to(beTrue())
                        default:
                            expect(false).to(beTrue())
                        }
                    })
                }

                it("should callback nil on parse error"){
                    apiClientMock.testCase = .parseError
                    sut.loadGenres(callback: { (result) in
                        switch result{
                        case .error:
                            expect(true).to(beTrue())
                        default:
                            expect(false).to(beTrue())
                        }
                    })
                }
            }
        }
    }
}
