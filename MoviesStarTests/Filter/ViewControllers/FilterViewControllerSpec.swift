//
//  FilterViewControllerSpec.swift
//  ios-trainning-projectTests
//
//  Created by m.marques.goncalves on 28/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Nimble_Snapshots
@testable import ios_trainning_project

class FilterViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        describe("FilterViewControllerSpec") {
            
            context("when UI is loaded", {
                
                beforeEach {
                    let dataSource = FilterDataSource(items: ["2018", "2017"])
                    let sut = FilterViewController(tableViewDataSource: dataSource)
                    UIWindow.setTestWindow(rootViewController: sut)
                }
                
                afterEach {
                    UIWindow.cleanTestWindow()
                }
                
                it("should present FilterViewController", closure: {
                    expect(UIWindow.testWindow) == snapshot("FilterViewController")
                })
                
            })
        }
    }
}
