import Foundation
import CoreData

public class GenreCoreDataManager {
    
    private var context:NSManagedObjectContext
    private let fetchRequest:NSFetchRequest = GenreEntity.fetchRequest()
    
    init(withContext context:NSManagedObjectContext = CoreDataHelper.defaultContext()) {
        self.context = context
    }
   
    func save(genres: [Genre]) {
        let managedContext = self.context
        guard let entity = NSEntityDescription.entity(forEntityName: "GenreEntity", in: managedContext) else {
            return
        }
        
        for genre in genres {
            
            if let _ = self.fetch(byID: genre.id) {continue}
            
            let genreEntity = NSManagedObject(entity: entity, insertInto: managedContext)
            genreEntity.setValue(genre.id, forKey: "id")
            genreEntity.setValue(genre.name, forKey: "name")
        }
        CoreDataHelper.save()
    }
    
    public func fetchAll() -> [GenreEntity] {
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        self.fetchRequest.sortDescriptors = [sortByName]
        
        do {
            let genres: [GenreEntity] = try self.context.fetch(self.fetchRequest) as [GenreEntity]
            return genres
        } catch {
            print("Could not fetch \(error.localizedDescription)")
            return []
        }
    }
    
    func fetch(byID id: Int) -> GenreEntity? {
        
        self.fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        
        do {
            return try context.fetch(self.fetchRequest).first
        }catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
        }
        return nil
    }
    
    func fetch(byName name: String) -> GenreEntity? {
        
        self.fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            return try context.fetch(self.fetchRequest).first
        }catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
        }
        return nil
    }
    
    
    func fetch(byIds ids: [Int]) -> [GenreEntity]? {
        
        self.fetchRequest.predicate = NSPredicate(format:"id IN %@",ids)
        
        do {
            return try context.fetch(self.fetchRequest)
        }catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
        }
        return nil
    }
    
    func fetch(byNames names: [String]) -> [GenreEntity]? {
        
        self.fetchRequest.predicate = NSPredicate(format:"name IN %@",names)
        
        do {
            return try context.fetch(self.fetchRequest)
        }catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
        }
        return nil
    }
    
    
    func fetch(byMovie movie:MovieEntity) -> [GenreEntity] {
        
        self.fetchRequest.predicate = NSPredicate(format:"ANY movies == %@",movie)
        do {
            return try context.fetch(self.fetchRequest)
        }catch {
            debugPrint("Could not fetch \(error.localizedDescription)")
        }
        return []
    }
    
}
