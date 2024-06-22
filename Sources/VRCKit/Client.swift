import Foundation
//
//  Client.swift
//
//
//  Created by makinosp on 2024/02/12.
//

let domainUrl = "https://api.vrchat.cloud"
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

    enum HttpMethod: String {
        case get
        case post
        case patch
        case put
        case delete
    }

    enum CookieKey: String {
        case auth, twoFactorAuth, apiKey
    }

    private enum ContentType: String {
        case json = "application/json"
    }

    private var username: String?
    private var password: String?
    private var cookies: [CookieKey: String] = [:]

    public init(username: String? = nil, password: String? = nil) {
        self.username = username
        self.password = password
    }

    public var isEmptyCookies: Bool {
        cookies.isEmpty
    }

    public func updateCookies() {
        cookies = [:]
        for cookie in HTTPCookieStorage.shared.cookies(for: URL(string: domainUrl)!)! {
            guard let key = CookieKey(rawValue: cookie.name) else { continue }
            cookies[key] = cookie.value
        }
    }

    public func deleteCookies() {
        cookies = [:]
        for cookie in HTTPCookieStorage.shared.cookies(for: URL(string: domainUrl)!)! {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }

    func request(
        url: URL,
        httpMethod: HttpMethod,
        basic: Bool = false,
        cookieKeys: [CookieKey] = [],
        httpBody: Data? = nil
    ) async throws -> HTTPResponse {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.description

        /// Authorization
        if basic {
            request.addValue(
                "Basic \(((username ?? "") + ":" + (password ?? "")).data(using: .utf8)!.base64EncodedString())",
                forHTTPHeaderField: "Authorization"
            )
        }
        
        /// Cookie
        request.addValue(
            cookies
                .map { "\($0.key.rawValue)=\($0.value)" }
                .joined(separator: "; "),
            forHTTPHeaderField: "Cookie"
        )

        /// HTTP Body
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
