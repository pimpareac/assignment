//
//  APICall.swift
//  CitySearch
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation

/// HTTP Request paramters
 typealias Parameters = [String: Any]

/// HTTP request headers like `["Content-Type": "application/json"]`
typealias HTTPHeaders = [String: String]

/// HTTP Request method
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}

// MARK: - APIError

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        }
    }
}

// MARK: - APICall

protocol APICall {
    /// API Endpoint path after base url
    var path: String { get }

    /// HTTP method
    var method: HTTPMethod { get }
    
    /// Request headers
    var headers: HTTPHeaders { get }
    
    /// Request body
    func body() throws -> Data?
}

// MARK: - APICall Default Implemetation

extension APICall {
    var method: HTTPMethod { HTTPMethod.get }
    
    var headers: HTTPHeaders { ["Accept": "application/json"] }
    
    func body() throws -> Data? { nil }
    
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}
