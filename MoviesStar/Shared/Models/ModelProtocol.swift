import Foundation
protocol ModelProtocol {
    
    associatedtype Model
    
    func add(data: Data) -> [Model]?
    func fetchAll() -> [Model]
    func fetchBy(ids:[Int]) -> [Model]
    func fetchBy(id: Int) -> Model?
}
