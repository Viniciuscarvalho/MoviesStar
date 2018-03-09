//
//  UIWindow+Helper.swift
//  ios-trainning-projectTests
//
//  Created by mariana.alvarez on 2/27/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    static var testWindow: UIWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: 467, height: 800))
    
    static func setTestWindow(rootViewController: UIViewController) {
        self.testWindow.rootViewController = rootViewController
        self.testWindow.makeKeyAndVisible()
    }
    
    static func cleanTestWindow() {
        self.testWindow.rootViewController = nil
        self.testWindow.isHidden = true
    }
}