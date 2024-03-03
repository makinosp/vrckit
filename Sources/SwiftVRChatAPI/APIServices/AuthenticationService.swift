//
//  AuthenticationService.swift
//  
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

//
// MARK: Authentication API
//

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct AuthenticationService {

    private static let authUrl = "\(baseUrl)/auth"
    private static let auth2FAUrl = "\(authUrl)/twofactorauth"

    public enum VerifyType: String {
        case emailOtp = "emailotp"
        case tOtp = "totp"
    }

    /// Check User Exists
    public static func isExists(_ client: APIClientAsync, userId: String) async throws -> Bool {
        var request = URLComponents(string: "\(authUrl)/exists")!
        request.queryItems = [URLQueryItem(name: "userId", value: userId.description)]
        guard let url = request.url else {
            throw URLError(
                .badURL,
                userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(authUrl)/exists"]
            )
        }

        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get
        )
        let exists = try JSONDecoder().decode(ExistsResponse.self, from: responseData)
        return exists.userExists
    }

    /// Login and/or Get Current User Info
    public static func loginUserInfo(_ client: APIClientAsync) async throws -> User {
        let url = URL(string: "\(authUrl)/user")!
        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            authorization: true,
            auth: true,
            twoFactorAuth: true
        )
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let user = try decoder.decode(User.self, from: responseData)
        client.updateCookies()
        return user
    }
    
    public static func verify2FA(
        _ client: APIClientAsync,
        verifyType: VerifyType,
        otp: String
    ) async throws -> Bool {
        let url = URL(string: "\(auth2FAUrl)/\(verifyType.rawValue)/verify")!
        let encoder = JSONEncoder()
        let requestData = try encoder.encode(VerifyCode(code: otp))

        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .post,
            auth: true,
            contentType: .json,
            httpBody: requestData
        )
        let verifyResponse = try JSONDecoder().decode(VerifyResponse.self, from: responseData)
        client.updateCookies()
        return verifyResponse.verified
    }
    
    public func logout(_ client: APIClientAsync) async throws {
        let url = URL(string: "\(baseUrl)/logout")!
        
        let (_, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .put,
            auth: true
        )
        client.updateCookies()
    }
}
