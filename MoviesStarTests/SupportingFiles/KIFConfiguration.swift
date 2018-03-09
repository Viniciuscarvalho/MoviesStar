//
//  KIFConfiguration.swift
//  ios-trainning-projectTests
//
//  Created by mariana.alvarez on 2/28/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Quick
import KIF

/**
 KIFConfiguration enables accessibility for KIF specs
 */
class KIFConfiguration: QuickConfiguration {
    /**
     tell KIF to enable accessibility for testing
     */
    class func enableAccessibilityBeforeSpecClassSetup() {
        KIFEnableAccessibility()
    }
    
    /**
     we have to prepare accessibility before any spec setup,
     which might use test actors relying on accessibility
     */
    override class func configure(_ configuration: Configuration) {
        enableAccessibilityBeforeSpecClassSetup()
    }
}
