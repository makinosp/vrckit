//
//  APIClient.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/12.
//

import Foundation

public final class APIClient {
    typealias HTTPResponse = (data: Data, response: HTTPURLResponse)

    private var username: String?
    private var password: String?
    private let baseUrl: String
    public let cookieManager: CookieManager

    enum Method: String {
        case get, post, patch, put, delete
    }

    private enum ContentType: String {
        case json = "application/json"
    }

    /// Initializes the API client with optional username and password.
    public init() {
        baseUrl = "\(Const.apiBaseUrl)/\(Const.apiVersion)"
        cookieManager = CookieManager(domainURL: Const.apiBaseUrl)
    }

    /// Set username and password.
    /// - Parameters:
    ///   - username: The username for basic authentication.
    ///   - password: The password for basic authentication.
    public func setCledentials(username: String, password: String) {
        self.username = username
        self.password = password
    }

    /// Encodes the given username and password into a Basic Authentication token.
    /// - Parameters:
    ///   - username: The username for authentication.
    ///   - password: The password associated with the username.
    /// - Returns: A Basic Authentication token string.
    /// - Throws: `VRCKitError.unexpectedError` if the username and password cannot be converted to UTF-8 data.
    private func encodeAuthorization(_ username: String, _ password: String) throws -> String {
        let authString = "\(username):\(password)"
        guard let payload = authString.data(using: .utf8) else {
            throw VRCKitError.unexpected
        }
        return "Basic \(payload.base64EncodedString())"
    }

    /// Sends a request to the API.
    /// - Parameters:
    ///   - path: The path for the request.
    ///   - method: The HTTP method to use for the request.
    ///   - basic: Whether to include basic authorization.
    ///   - queryItems: An array of `URLQueryItem` to include in the request.
    ///   - body: The HTTP body to include in the request.
    /// - Returns: A tuple containing the data and the HTTP response.
    /// - Throws: `VRCKitError` if an error occurs during the request.
    func request(
        path: String,
        method: Method,
        basic: Bool = false,
        queryItems: [URLQueryItem] = [],
        body: Data? = nil
    ) async throws -> HTTPResponse {
        guard var urlComponents = URLComponents(string: "\(baseUrl)/\(path)") else {
            throw VRCKitError.urlError
        }
        if !queryItems.isEmpty {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            throw VRCKitError.urlError
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.description

        // Add authorization header if required.
        if basic, let username = username, let password = password {
            let authorizationHeader = try encodeAuthorization(username, password)
            request.addValue(authorizationHeader, forHTTPHeaderField: "Authorization")
        }

        // Add cookies to the request headers.
        request.allHTTPHeaderFields = cookieManager.httpField

        // Add HTTP body and content type if body is provided.
        if let body = body {
            request.addValue(ContentType.json.rawValue, forHTTPHeaderField: "Content-Type")
            request.httpBody = body
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw VRCKitError.invalidResponse
        }
        return (data, response)
    }
}

extension APIClient.Method: CustomStringConvertible {
    var description: String {
        self.rawValue.uppercased()
    }
}
