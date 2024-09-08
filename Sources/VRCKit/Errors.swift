//
//  Errors.swift
//  VRCKit
//
//  Created by makinosp on 2024/04/28.
//

import Foundation

/// An enumeration that represents various errors that can occur in the VRCKit framework.
/// Conforms to the `Error` and `LocalizedError` protocols for better error handling and localization.
public enum VRCKitError: Error, LocalizedError {
    private typealias RawValue = String

    /// Represents an error from the API with details.
    case apiError(_ details: String)

    /// Represents an error indicating that the client has been deallocated.
    case clientDeallocated

    /// Represents an error indicating an invalid response was received.
    case invalidResponse

    /// Represents an error indicating an invalid request with additional details.
    case invalidRequest(_ details: String)

    /// Represents an error indicating an authentication failure.
    case unauthorized

    /// Represents an unexpected error.
    case unexpected

    /// Represents an url error.
    case urlError

    /// Provides a localized description of the error.
    public var errorDescription: String? {
        switch self {
        case .apiError: "API Error"
        case .clientDeallocated: "Client Deallocated"
        case .invalidResponse: "Invalid Response"
        case .invalidRequest: "Invalid Request"
        case .unauthorized: "Unauthorized"
        case .unexpected: "Unexpected"
        case .urlError: "URL Error"
        }
    }

    /// Provides a localized failure reason for the error.
    public var failureReason: String? {
        switch self {
        case .apiError(let details), .invalidRequest(let details):
            details
        default:
            errorDescription
        }
    }
}
