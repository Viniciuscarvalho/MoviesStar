import Foundation

@testable import MoviesStar

class APIClientMock: Client {
    
    enum APITestCases {
        case success
        case parseError
        case error
        
        func result(endpoint: Endpoints) -> Result<Data>{
            switch self {
            case .success:
                switch endpoint {
                case .popular:
                    return .success(LoadJson.loadListResultJson())
                case .genre:
                    return .success(LoadJson.loadGenreListResultData())
                }
            case .parseError:
                return .success(Data())
            case .error:
                return .error(.invalidData)
            }
        }
    }

    var testCase: APITestCases = .error
    
    func request(endpoint: Endpoints, callback: @escaping (Result<Data>) -> Void) {
        callback(testCase.result(endpoint: endpoint))
    }
}
