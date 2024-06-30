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
@available(macOS 12.0, *)
@available(iOS 15.0, *)
public class APIClient {
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

    public init(username: String? = nil, password: String? = nil) {
        self.username = username
        self.password = password
    }

    public var cookies: [HTTPCookie] {
        HTTPCookieStorage.shared.cookies(for: domainUrl) ?? []
    }

    public func deleteCookies() {
        for cookie in cookies {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }

    var encodedAuthorization: String {
        "Basic \(((username ?? "") + ":" + (password ?? "")).data(using: .utf8)!.base64EncodedString())"
    }

    /// Request to API
    func request(
        url: URL,
        httpMethod: HttpMethod,
        basic: Bool = false,
        httpBody: Data? = nil
    ) async throws -> HTTPResponse {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.description

        // Authorization
        if basic {
            request.addValue(encodedAuthorization, forHTTPHeaderField: "Authorization")
        }

        // Cookie
        request.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: cookies)

        // HTTP Body
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

@available(macOS 12.0, *)
@available(iOS 15.0, *)
extension APIClient.HttpMethod: CustomStringConvertible {
    var description: String {
        self.rawValue.uppercased()
    }
}
