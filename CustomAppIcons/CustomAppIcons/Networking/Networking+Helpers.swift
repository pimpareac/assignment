//
//  Networking+Helpers.swift
//  CitySearch
//
//  Created by Amol Pimpare on 13/02/21.
//

import Combine
import Foundation

private extension Error {
    var underlyingError: Error? {
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain,
           nsError.code == NSURLErrorNotConnectedToInternet {
            return self
        }
        
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}

extension Publisher {
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError {
            ($0.underlyingError as? Failure) ?? $0
        }
    }
}
