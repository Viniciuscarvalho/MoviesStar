import Foundation

class GenreController{
    
    var coreDataManager:GenreCoreDataManager
    
    init(with genreCoreDataManager: GenreCoreDataManager = GenreCoreDataManager()){
        self.coreDataManager = genreCoreDataManager    
    }
    
    func save(genres:[Genre]){
        DispatchQueue.main.async {
            self.coreDataManager.save(genres: genres)
        }
    }
    
    func genreNames(genres: [Genre], for ids: [Int]) -> [String] {
        var names: [String] = []
        var sortedIds: [Int] = ids.sorted(by: {$0 < $1})
        var idIndex: Int = 0
        
        for genre in genres.sorted(by: {$0.id < $1.id}){
            if genre.id == sortedIds[idIndex]{
                names.append(genre.name)
                idIndex += 1
            }
            
            if names.count == ids.count{
                break
            }
        }
        return names
    }
}
extension GenreController: ModelProtocol{
    
    typealias Model = Genre
    
    func add(data: Data) -> [Genre]? {
        do {
            let genreList = try JSONDecoder().decode(GenreList.self, from: data)
            return genreList.genres
        }catch{
            return nil
        }
    }
    
    func fetchAll() -> [Genre] {
        var genres: [Genre] = []
        
        let fetchedGenres = self.coreDataManager.fetchAll()
        
        for genre in fetchedGenres{
            genres.append(Genre(id: Int(genre.id),
                                name: genre.name))
        }
        return genres
    }
    
    func fetchBy(ids: [Int]) -> [Genre] {
        
        guard let entities = self.coreDataManager.fetch(byIds: ids) else {return []}
        var genres:[Genre] = []
        for entity in entities {
            genres.append(Genre(id: Int(entity.id),
                                name: entity.name))
        }
        return genres
    }
    
    func fetchBy(id: Int) -> Genre? {
        if let genreEntity = self.coreDataManager.fetch(byID: id) {
            return Genre(id: Int(genreEntity.id), name: genreEntity.name)
        }
        return nil
    }
    
    func fetchBy(name: String) -> Genre? {
        if let genreEntity = self.coreDataManager.fetch(byName: name) {
            return Genre(id: Int(genreEntity.id), name: genreEntity.name)
        }
        return nil
    }
    
}
