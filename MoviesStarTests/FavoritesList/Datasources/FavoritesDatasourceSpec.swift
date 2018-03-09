//
//  FavoritesDatasourceSpec.swift
//  ios-trainning-projectTests
//
//  Created by Jose Freitas on 26/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ios_trainning_project

class FavoritesDatasourceSpec: QuickSpec {
    
    override func spec() {
        describe("FavoritesDatasource") {
            let fakeTableView = UITableView(frame: .zero)
            let movie = Movie(id: 1, title: "", posterPath: "", releaseDate: "", genreIds: [1], overview: "")
            var sut = FavoritesDatasource(with: [movie, movie, movie], tableView: fakeTableView)
            let customIndexPath = IndexPath(row: 0, section: 0)
            
            context("when created") {
                
                it("tableView should not be nil") {
                    expect(sut.tableView).toNot(beNil())
                }
                
                it("tableView dataSource should be FavoritesDataSource") {
                    expect(sut.tableView.dataSource).to(beAKindOf(FavoritesDatasource.self))
                }
                
                it("tableView delegate should be FavoritesDataSource") {
                    expect(sut.tableView.delegate).to(beAKindOf(FavoritesDatasource.self))
                }
                
                it("should assert number of rows") {
                    expect(sut.tableView.numberOfRows(inSection: 0)).to(equal(3))
                }
                
                it("should configure cells") {
                    let cell = sut.tableView(fakeTableView, cellForRowAt: customIndexPath)
                    expect(cell).toNot(beNil())
                }
            }
            
            context("when requested to unfavorite a movie") {
                
                it("should return title Unfavorite for delete button") {
                    let deleteTitle = sut.tableView(fakeTableView, titleForDeleteConfirmationButtonForRowAt: customIndexPath)
                    expect(deleteTitle).to(equal("Unfavorite"))
                }
                
                it("should allow cells to be edited") {
                    let cellsCanBeEdited = sut.tableView(fakeTableView, canEditRowAt: customIndexPath)
                    expect(cellsCanBeEdited).to(be(true))
                }
                
                it("should update movies source") {
                    sut.tableView(fakeTableView, commit: UITableViewCellEditingStyle.delete, forRowAt: customIndexPath)
                    expect(sut.tableView.numberOfRows(inSection: 0)).to(equal(2))
                }
                
                afterEach {
                    sut = FavoritesDatasource(with: [movie, movie, movie], tableView: fakeTableView)
                }
            }
        
            context("when requested to update movies") {
                it("should return new number of rows"){
                    sut.update(movies: [movie, movie, movie, movie, movie])
                    expect(sut.tableView.numberOfRows(inSection: 0)).to(equal(5))
                }
                
                afterEach {
                    sut = FavoritesDatasource(with: [movie, movie, movie], tableView: fakeTableView)
                }
            }
        }
    }
}
