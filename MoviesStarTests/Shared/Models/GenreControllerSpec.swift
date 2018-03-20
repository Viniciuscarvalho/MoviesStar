import Foundation
import Quick
import Nimble
import CoreData

@testable import MoviesStar


class GenreControllerSpec:QuickSpec{
    
    override func spec() {
        
        describe("GenreController") {

            let coreDataManager = GenreCoreDataManagerStub()

            let sut = GenreController(with: coreDataManager)

            context("when receive results") {

                let data = LoadJson.loadGenreListResultData()
                let genres = sut.add(data: data)

                it("should parse results not null", closure: {
                    expect(genres).toNot(beNil())
                })

                it("should parse results", closure: {
                    expect(genres?.count).to(beGreaterThan(0))
                })

            }

            context("when receive empty result", closure: {
                let data = LoadJson.loadEmptyGenreListResultData()
                let genres = sut.add(data: data)
                it("should parse empty results", closure: {
                    expect(genres?.count).to(equal(0))
                 })
            })

            context("when receive invalid result"){
                let data = LoadJson.loadInvalidResultData()
                let genres = sut.add(data: data)

                it("should receive nil", closure: {
                    expect(genres).to(beNil())
                })
            }

            context("when fetch results") {

                it("should fetch all Genres", closure: {
                    expect(sut.fetchAll().count).to(equal(3))
                })

                it("should fetch genre by unique ID") {
                    let fetchedId = 12
                    let fetchedResult = sut.fetchBy(id: fetchedId)

                    expect(fetchedResult).toNot(beNil())
                    expect(fetchedResult!.id).to(equal(fetchedId))
                }

                it("should fetch genre by multiples ids") {
                    expect(sut.fetchBy(ids: [12,28]).count).to(equal(2))
                }

                it("should fetch genre by invalid ID") {
                    expect(sut.fetchBy(id: 0)).to(beNil())
                }

                it("should fetch genre by multiples invalid ids") {
                    expect(sut.fetchBy(ids: [0,-1]).count).to(equal(0))
                }

                it("should fetch genre by multiples ids containing invalid id") {
                    expect(sut.fetchBy(ids: [12,16,0]).count).to(equal(2))
                }

                it("should get entity name") {
                    let genres = sut.fetchAll()
                    let ids = [12,16]
                    let result = sut.genreNames(genres: genres, for:ids)

                    expect(result.count).to(equal(2))
                    expect(result[0]).to(equal("Adventure"))
                    expect(result[1]).to(equal("Animation"))
                }
            }
        }
    }
}
