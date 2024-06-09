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
    case apiError(_ details: String)
    case invalidResponseError
    case invalidRequest(_ details: String)
    case unexpectedError

    public var errorDescription: String? {
        return switch self {
        case .encodingError:
            "Encoding Error"
        case .apiError(let _):
            "API Error"
        case .invalidResponseError:
            "Invalid Response Error"
        case .invalidRequest:
            "Invalid Request"
        case .unexpectedError:
            "Unexpected Error"
        }
    }

    public var failureReason: String? {
        return switch self {
        case .apiError(let details), .invalidRequest(let details):
            details
        default:
            errorDescription
        }
    }
}
