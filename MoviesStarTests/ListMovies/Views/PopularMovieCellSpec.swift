//
//  PopularMovieCellSpec.swift
//  ios-trainning-projectTests
//
//  Created by mariana.alvarez on 2/15/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import ios_trainning_project

class PopularMovieCellSpec: QuickSpec {
    
    var sut: PopularMovieCell!

    override func spec() {

        describe("PopularMovieCell") {

            beforeEach {
                self.sut = Bundle.main.loadNibNamed("PopularMovieCell", owner: nil, options: nil)?.first as! PopularMovieCell
                self.sut.movieTitle?.text = "Thor"
                self.sut.imageView?.image = UIImage()
            }

            it("should have valis snapshot") {
                expect(self.sut) == snapshot("PopularMovieCell")
            }

        }


    }
    
}
