//
//  FilterCategoriesViewControllerStub.swift
//  ios-trainning-projectTests
//
//  Created by m.marques.goncalves on 28/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import UIKit
@testable import ios_trainning_project

class FilterCategoriesViewControllerStub: FilterCategoriesViewController {
    
    var showFilterViewControllerCalled: Bool = false
    var applyButtonTappedCalled: Bool = false
    
    override func showFilterViewController(category: FilterCategory) {
        showFilterViewControllerCalled = true
        super.showFilterViewController(category: category)
    }
    
    override func applyButtonTapped() {
        applyButtonTappedCalled = true
        super.applyButtonTapped()
    }
}
