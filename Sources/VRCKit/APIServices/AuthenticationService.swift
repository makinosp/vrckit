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

    /// Check User Exists
    public static func isExists(_ client: APIClientAsync, userId: String) async throws -> Bool {
        var request = URLComponents(string: "\(authUrl)/exists")!
        request.queryItems = [URLQueryItem(name: "username", value: userId.description)]
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
    public static func loginUserInfo(_ client: APIClientAsync) async throws -> WrappedUserResponse {
        let url = URL(string: "\(authUrl)/user")!
        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            authorization: true,
            auth: true,
            twoFactorAuth: true
        )

        // Try decoding with the structure for two-step authentication
        // and if it fails, decode with the user structure.
        var wrappedUserResponse: WrappedUserResponse

        if let requiresTwoFactorAuth = try? Common.shared.decoder.decode(
            RequiresTwoFactorAuthResponse.self,
            from: responseData
        ) {
            wrappedUserResponse = WrappedUserResponse(
                user: nil,
                requiresTwoFactorAuth: requiresTwoFactorAuth.requiresTwoFactorAuth.map { $0.lowercased() }
            )
        } else {
            let user = try Common.shared.decoder.decode(User.self, from: responseData)
            wrappedUserResponse = WrappedUserResponse(user: user, requiresTwoFactorAuth: [])
        }
        
        client.updateCookies()
        return wrappedUserResponse
    }
    
    /// Verify 2FA With TOTP or Email OTP
    public static func verify2FA(
        _ client: APIClientAsync,
        verifyType: String,
        code: String
    ) async throws -> Bool {
        let url = URL(string: "\(auth2FAUrl)/\(verifyType)/verify")!
        let encoder = JSONEncoder()
        let requestData = try encoder.encode(VerifyRequest(code: code))

        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .post,
            auth: true,
            twoFactorAuth: true,
            contentType: .json,
            httpBody: requestData
        )
        let verifyResponse = try JSONDecoder().decode(VerifyResponse.self, from: responseData)
        client.updateCookies()
        return verifyResponse.verified
    }

    /// Verify Auth Token
    public static func verifyAuthToken(_ client: APIClientAsync) async throws -> Bool {
        client.updateCookies()
        let url = URL(string: authUrl)!
        let (responseData, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            auth: true,
            twoFactorAuth: true
        )
        if let veryfyAuthTokenResponse = try? JSONDecoder().decode(VerifyAuthTokenResponse.self, from: responseData) {
            return veryfyAuthTokenResponse.ok
        } else {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: responseData)
            return false
        }
    }

    /// Logout
    public static func logout(_ client: APIClientAsync) async throws {
        let url = URL(string: "\(baseUrl)/logout")!
        
        let (_, _) = try await client.VRChatRequest(
            url: url,
            httpMethod: .put,
            auth: true
        )
        client.updateCookies()
    }
}
