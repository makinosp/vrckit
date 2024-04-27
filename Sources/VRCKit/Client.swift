import Foundation
//
//  Client.swift
//
//
//  Created by makinosp on 2024/02/12.
//

//
// MARK: API Client
//

enum HttpMethod: String {
    case get
    case post
    case patch
    case put
    case delete
}

enum VRCKitError: Error {
    case encodingError
}

enum ContentType: String {
    case json = "application/json"
}

public enum VRCCookieKey: String {
    case auth
    case twoFactorAuth
    case apiKey
}

typealias HTTPResponse = (data: Data, urlResponse: URLResponse)

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public class APIClientAsync {
    private var username: String?
    private var password: String?
    
    // Cookies
    private var auth: String?
    private var twoFactorAuth: String?
    private var apiKey: String?

    public init(username: String? = nil, password: String? = nil) {
        self.username = username
        self.password = password
    }
    
    public func updateCookies() {
        self.auth = nil
        self.twoFactorAuth = nil
        self.apiKey = nil
        for cookie in HTTPCookieStorage.shared.cookies(for: URL(string: domainUrl)!)! {
            if cookie.name == "auth" {
                self.auth = cookie.value
            } else if cookie.name == "twoFactorAuth" {
                self.twoFactorAuth = cookie.value
            } else if cookie.name == "apiKey" {
                self.apiKey = cookie.value
            }
        }
        
        // Debug
//        print("*** updateCookies() ***")
//        print("auth: \(auth)")
//        print("twoFactorAuth: \(twoFactorAuth)")
//        print("apiKey: \(apiKey)")
        // Debug End
    }

    public func getCookie(_ key: VRCCookieKey) -> String? {
        switch key {
        case .auth:
            return auth
        case .twoFactorAuth:
            return twoFactorAuth
        case .apiKey:
            return apiKey
        }
    }

    func VRChatRequest(
        url: URL,
        httpMethod: HttpMethod,
        basic: Bool = false,
        auth: Bool = false,
        twoFactorAuth: Bool = false,
        apiKey: Bool = false,
        cookieKeys: [VRCCookieKey] = [],
        contentType: ContentType? = nil,
        httpBody: Data? = nil
    ) async throws -> HTTPResponse {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue.uppercased()

        /// Authorization
        if basic, let username = username, let password = password {
            request.addValue(
                "Basic \(username):\(password)".data(using: .utf8)!.base64EncodedString(),
                forHTTPHeaderField: "Authorization"
            )
        }
        
        /// Cookie
        let cookies = cookieKeys.compactMap { key in
            getCookie(key).map { "\(key.rawValue)=\($0)" }
        }
        request.addValue(cookies.joined(separator: "; "), forHTTPHeaderField: "Cookie")

        /// HTTP Body
        if let contentType = contentType, let httpBody = httpBody {
            request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
            request.httpBody = httpBody
        }

        return try await URLSession.shared.data(for: request)
    }
}
