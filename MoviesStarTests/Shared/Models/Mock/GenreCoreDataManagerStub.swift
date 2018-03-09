//
//  GenreCoreDataManagerStub.swift
//  ios-trainning-projectTests
//
//  Created by Rafael Aparecido de Freitas  on 27/02/18.
//  Copyright © 2018 Concrete - Treinamento iOS. All rights reserved.
//

import UIKit
import CoreData

@testable import ios_trainning_project

class GenreCoreDataManagerStub: GenreCoreDataManager {
   
    let contextMock: CoreDataContextMock
    let managedObjectContext: NSManagedObjectContext
    
    
    init(){
        self.contextMock = CoreDataContextMock()
        managedObjectContext = self.contextMock.createManagedObjectContext()
    }
    
    
    override func fetch(byIds ids: [Int]) -> [GenreEntity]? {
        
        let entities = self.getEntities()
        
        var resut: [GenreEntity] = []
        
        for entity in entities {
            for id in ids {
                if Int(entity.id) == id {
                    resut.append(entity)
                }
            }
        }
        return resut
    }
    
    
    override func fetch(byID id: Int) -> GenreEntity? {
        
        let entities = self.getEntities()
        
        for entity in entities {
            if Int(entity.id) == id {
                return entity
            }
        }
        return nil
    }
    
    override func fetchAll() -> [GenreEntity] {
        return self.getEntities()
    }
    
    private func getEntities() -> [GenreEntity] {
        
        var entities:[GenreEntity] = []
        
        let g1 = GenreEntity(context: managedObjectContext)
        g1.name = "Action"
        g1.id = 28
        entities.append(g1)
        
        let g2 = GenreEntity(context: managedObjectContext)
        g2.name = "Adventure"
        g2.id = 12
        entities.append(g2)
        
        let g3 = GenreEntity(context: managedObjectContext)
        g3.name = "Animation"
        g3.id = 16
        entities.append(g3)
        
        return entities
    }
    
}
