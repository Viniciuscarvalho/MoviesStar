//
//  NavigationControllerSpec.swift
//  ios-trainning-projectTests
//
//  Created by mariana.alvarez on 2/26/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots
@testable import ios_trainning_project

class NavigationControllerSpec: QuickSpec {
    
    override func spec() {
        
        var sut: NavigationController!
        
        describe("NavigationController") {
            
            context("when initialized", {
                
                beforeEach {
                    let viewController = UIViewController()
                    viewController.view.backgroundColor = .red
                    viewController.title = "Movies"
                    
                    sut = NavigationController(rootViewController: viewController)
                    
                    UIWindow.setTestWindow(rootViewController: sut)
                }
                
                afterEach {
                    UIWindow.cleanTestWindow()
                }
                
                it("should have expected layout") {
                    expect(UIWindow.testWindow) == snapshot("NavigationController")
                }
            })
            
            context("when created with coder") {
                let sut = NavigationController(coder: NSCoder())
                it("should be nil") {
                    expect(sut).to(beNil())
                }
            }
        }
    }
}