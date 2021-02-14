//
//  WebRepository.swift
//  CitySearch
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
}

extension WebRepository {
    func call<Value>(endpoint: APICall) -> AnyPublisher<Value, Error> where Value: Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .parseJSON()
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: - Parsing

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func parseJSON<Value>() -> AnyPublisher<Value, Error> where Value: Decodable {
        return tryMap { (output: (data: Data, response: URLResponse)) -> Data in
            guard let httpResponse = output.response as? HTTPURLResponse else {
                throw APIError.unexpectedResponse
            }
            
            guard HTTPCodes.success.contains(httpResponse.statusCode) == true else {
                throw APIError.httpCode(httpResponse.statusCode)
            }
            
            return output.data
        }
        .extractUnderlyingError()
        .decode(type: Value.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
