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
        guard let url = request.url else { return false }
        let response = try await client.VRChatRequest(
            url: url,
            httpMethod: .get
        )
        switch Util.shared.decodeResponse(response.data) as Result<ExistsResponse, ErrorResponse> {
        case .success(let success):
            return success.userExists
        case .failure(_):
            return false
        }
    }

    public enum LoginUserInfoResult<T: Codable, U: Codable, V: Codable> {
        case user(T)
        case requiresTwoFactorAuth(U)
        case failure(V)
    }

    /// Login and/or Get Current User Info
    public static func loginUserInfo(
        _ client: APIClientAsync
    ) async throws -> LoginUserInfoResult<User, [String], ErrorResponse> {
        let response = try await client.VRChatRequest(
            url: URL(string: "\(authUrl)/user")!,
            httpMethod: .get,
            basic: true,
            cookieKeys: [.auth, .twoFactorAuth]
        )
        do {
            switch Util.shared.decodeResponse(response.data) as Result<User, ErrorResponse> {
            case .success(let user):
                client.updateCookies()
                return .user(user)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            switch Util.shared.decodeResponse(response.data) as Result<RequiresTwoFactorAuthResponse, ErrorResponse> {
            case .success(let factors):
                client.updateCookies()
                return .requiresTwoFactorAuth(factors.requiresTwoFactorAuth.map { $0.lowercased() })
            case .failure(let error):
                return .failure(error)
            }
        }
    }
    
    /// Verify 2FA With TOTP or Email OTP
    public static func verify2FA(
        _ client: APIClientAsync,
        verifyType: String,
        code: String
    ) async throws -> Bool {
        let requestData = try Util.shared.encodeRequest(VerifyRequest(code: code)).get()
        let response = try await client.VRChatRequest(
            url: URL(string: "\(auth2FAUrl)/\(verifyType)/verify")!,
            httpMethod: .post,
            auth: true,
            twoFactorAuth: true,
            contentType: .json,
            httpBody: requestData
        )
        switch Util.shared.decodeResponse(response.data) as Result<VerifyResponse, ErrorResponse> {
        case .success(let response):
            client.updateCookies()
            return response.verified
        case .failure(_):
            return false
        }
    }

    /// Verify Auth Token
    public static func verifyAuthToken(_ client: APIClientAsync) async throws -> Bool {
        client.updateCookies()
        let url = URL(string: authUrl)!
        let response = try await client.VRChatRequest(
            url: url,
            httpMethod: .get,
            auth: true,
            twoFactorAuth: true
        )
        let veryfyAuthTokenResponse: Result<VerifyAuthTokenResponse, ErrorResponse> = Util.shared.decodeResponse(response.data)
        switch veryfyAuthTokenResponse {
        case .success(let success):
            return success.ok
        case .failure(_):
            return false
        }
    }

    /// Logout
    public static func logout(_ client: APIClientAsync) async throws {
        let _ = try await client.VRChatRequest(
            url: URL(string: "\(baseUrl)/logout")!,
            httpMethod: .put,
            auth: true
        )
        client.updateCookies()
    }
}
