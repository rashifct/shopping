//
//  NetworkService.swift
//  Shopping
//
//  Created by Rashif on 28/08/23.
//

import Alamofire
import Combine

class NetworkService {
    
    static let shared = NetworkService()
    
    private let baseURL = "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0"
    
    private init() {}
    
    func fetchData<T: Codable>() -> AnyPublisher<T, Error> {
        guard let requestURL = URL(string: baseURL) else {
            return Fail(outputType: T.self, failure: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return AF.request(requestURL)
            .validate()
            .publishDecodable(type: T.self)
            .compactMap { $0.value }
            .mapError { _ -> Error in
                URLError(.cannotParseResponse)
            }
            .eraseToAnyPublisher()
    }
}
