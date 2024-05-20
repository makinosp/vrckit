//
//  Errors.swift
//  
//
//  Created by makinosp on 2024/04/28.
//

import Foundation

public enum VRCKitError: Error, LocalizedError {
    public typealias RawValue = String

    case encodingError
    case apiError(message: String)
    case unexpectedError

    public var errorDescription: String? {
        switch self {
        case .encodingError:
            return "Encoding Error"
        case .apiError(let _):
            return "API Error"
        case .unexpectedError:
            return "Unexpected Error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .encodingError:
            return "Encoding has failed."
        case .apiError(let message):
            return message
        case .unexpectedError:
            return "Unexpected error"
        }
    }
}
