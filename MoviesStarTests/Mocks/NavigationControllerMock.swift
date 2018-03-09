//
//  NavigationControllerMock.swift
//  ios-trainning-projectTests
//
//  Created by Jose Freitas on 01/03/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import ios_trainning_project

class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    internal override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
    }
}
