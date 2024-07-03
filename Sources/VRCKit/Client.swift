import Foundation
//
//  Client.swift
//
//
//  Created by makinosp on 2024/02/12.
//

let baseUrl = "https://api.vrchat.cloud/api/1"

public struct ResponseMessage: Codable {
    let message: String
    let statusCode: Int
}

public struct SuccessResponse: Codable {
    let success: ResponseMessage
}

public struct ErrorResponse: Codable, Error {
    let error: ResponseMessage
}

//
// MARK: API Client
//
@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
public final class APIClient {
    typealias HTTPResponse = (data: Data, response: HTTPURLResponse)

    private var username: String?
    private var password: String?
    private let domainUrl = URL(string: "https://api.vrchat.cloud")!

    enum HttpMethod: String {
        case get, post, patch, put, delete
    }

    private enum ContentType: String {
        case json = "application/json"
    }

    /// Initializes the API client with optional username and password.
    /// - Parameters:
    ///   - username: The username for basic authentication.
    ///   - password: The password for basic authentication.
    public init(username: String? = nil, password: String? = nil) {
        self.username = username
        self.password = password
    }

    /// Retrieves the cookies stored for the VRChat API domain.
    /// - Returns: An array of `HTTPCookie` objects.
    public var cookies: [HTTPCookie] {
        guard let cookies = HTTPCookieStorage.shared.cookies(for: domainUrl) else { return [] }
        return cookies
    }

    /// Deletes all cookies stored for the VRChat API domain.
    public func deleteCookies() {
        cookies.forEach { HTTPCookieStorage.shared.deleteCookie($0) }
    }

    /// Encodes the given username and password into a Basic Authentication token.
    /// - Parameters:
    ///   - username: The username for authentication.
    ///   - password: The password associated with the username.
    /// - Returns: A Basic Authentication token string.
    /// - Throws: `VRCKitError.unexpectedError` if the username and password cannot be converted to UTF-8 data.
    func encodeAuthorization(_ username: String, _ password: String) throws -> String {
        let authString = "\(username):\(password)"
        guard let payload = authString.data(using: .utf8) else {
            throw VRCKitError.unexpectedError
        }
        return "Basic \(payload.base64EncodedString())"
    }

    /// Sends a request to the API.
    /// - Parameters:
    ///   - url: The URL for the request.
    ///   - httpMethod: The HTTP method to use for the request.
    ///   - basic: Whether to include basic authorization.
    ///   - httpBody: The HTTP body to include in the request.
    /// - Returns: A tuple containing the data and the HTTP response.
    /// - Throws: `VRCKitError` if an error occurs during the request.
    func request(
        url: URL,
        httpMethod: HttpMethod,
        basic: Bool = false,
        httpBody: Data? = nil
    ) async throws -> HTTPResponse {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.description

        // Add authorization header if required.
        if basic, let username = username, let password = password {
            let authorizationHeader = try encodeAuthorization(username, password)
            request.addValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        }

        // Add cookies to the request headers.
        request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: cookies)

        // Add HTTP body and content type if body is provided.
        if let httpBody = httpBody {
            request.addValue(ContentType.json.rawValue, forHTTPHeaderField: "Content-Type")
            request.httpBody = httpBody
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw VRCKitError.invalidResponseError
        }
        return (data, response)
    }
}

@available(macOS 12.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
extension APIClient.HttpMethod: CustomStringConvertible {
    var description: String {
        self.rawValue.uppercased()
    }
}
