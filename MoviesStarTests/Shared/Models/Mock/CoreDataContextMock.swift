//
//  CoreDataContextMock.swift
//  ios-trainning-projectTests
//
//  Created by Rafael Aparecido de Freitas  on 28/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import Foundation
import CoreData

class CoreDataContextMock {
    
    func createManagedObjectContext() -> NSManagedObjectContext {
        let url = Bundle.main.url(forResource: "ios_trainning_project", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: url)
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Error to create mock for NSManagedObjectContext")
        }
        
        let managedObjecContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjecContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjecContext
    }
    
    
}
