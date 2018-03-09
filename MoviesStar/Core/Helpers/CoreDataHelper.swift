//
//  CoreDataHelper.swift
//  ios-trainning-project
//
//  Created by Vinicius Marques on 21/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    
    static func defaultContext() -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Error loading AppDelegate shared instance")
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    static func save() {
        do {
            try CoreDataHelper.defaultContext().save()
        } catch {
            print("Could not save object")
        }
    }
    
}
