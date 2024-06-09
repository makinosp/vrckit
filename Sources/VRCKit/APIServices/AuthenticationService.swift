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

public protocol UserOrRequires {}
extension User: UserOrRequires {}
extension [TwoFactorAuthType]: UserOrRequires {}

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct AuthenticationService {

    private static let authUrl = "\(baseUrl)/auth"
    private static let auth2FAUrl = "\(authUrl)/twofactorauth"

    /// Check User Exists
    public static func isExists(_ client: APIClient, userId: String) async throws -> Bool {
        var request = URLComponents(string: "\(authUrl)/exists")!
        request.queryItems = [URLQueryItem(name: "username", value: userId.description)]
        guard let url = request.url else { return false }
        let response = try await client.request(
            url: url,
            httpMethod: .get
        )
        switch Util.shared.decodeResponse(response.data) as Result<ExistsResponse, ErrorResponse> {
        case .success(let success):
            return success.userExists
        case .failure(let errorResponse):
            throw VRCKitError.apiError(errorResponse.error.message)
        }
    }

    /// Login and/or Get Current User Info
    public static func loginUserInfo(
        _ client: APIClient
    ) async throws -> UserOrRequires {
        let response = try await client.request(
            url: URL(string: "\(authUrl)/user")!,
            httpMethod: .get,
            basic: true,
            cookieKeys: [.auth, .twoFactorAuth]
        )
        switch Util.shared.decodeResponse(response.data) as Result<User, ErrorResponse> {
        case .success(let user):
            client.updateCookies()
            return user
        case .failure(let errorResponse):
            if errorResponse.error.statusCode > -1 {
                throw VRCKitError.apiError(errorResponse.error.message)
            }
            switch Util.shared.decodeResponse(response.data) as Result<RequiresTwoFactorAuthResponse, ErrorResponse> {
            case .success(let factors):
                client.updateCookies()
                return factors.requiresTwoFactorAuth
            case .failure(let errorResponse):
                throw VRCKitError.apiError(errorResponse.error.message)
            }
        }
    }

    public static func getVerifyType(_ requiresTwoFactorAuth: [TwoFactorAuthType]) -> TwoFactorAuthType? {
        var verifyType: TwoFactorAuthType?
        if requiresTwoFactorAuth.contains(.totp) {
            verifyType = .totp
        } else if requiresTwoFactorAuth.contains(.emailotp) {
            verifyType = .emailotp
        }
        return verifyType
    }

    /// Verify 2FA With TOTP or Email OTP
    public static func verify2FA(
        _ client: APIClient,
        verifyType: TwoFactorAuthType,
        code: String
    ) async throws -> Bool {
        let requestData = try Util.shared.encodeRequest(VerifyRequest(code: code)).get()
        let response = try await client.request(
            url: URL(string: "\(auth2FAUrl)/\(verifyType.rawValue)/verify")!,
            httpMethod: .post,
            cookieKeys: [.auth, .twoFactorAuth],
            httpBody: requestData
        )
        switch Util.shared.decodeResponse(response.data) as Result<VerifyResponse, ErrorResponse> {
        case .success(let response):
            client.updateCookies()
            return response.verified
        case .failure(let errorResponse):
            throw VRCKitError.apiError(errorResponse.error.message)
        }
    }

    /// Verify Auth Token
    public static func verifyAuthToken(_ client: APIClient) async throws -> Bool {
        client.updateCookies()
        let url = URL(string: authUrl)!
        let response = try await client.request(
            url: url,
            httpMethod: .get,
            cookieKeys: [.auth, .twoFactorAuth]
        )
        let veryfyAuthTokenResponse: Result<VerifyAuthTokenResponse, ErrorResponse> = Util.shared.decodeResponse(response.data)
        switch veryfyAuthTokenResponse {
        case .success(let success):
            return success.ok
        case .failure(let errorResponse):
            throw VRCKitError.apiError(errorResponse.error.message)
        }
    }

    /// Logout
    public static func logout(_ client: APIClient) async throws {
        let _ = try await client.request(
            url: URL(string: "\(baseUrl)/logout")!,
            httpMethod: .put,
            cookieKeys: [.auth]
        )
        client.updateCookies()
    }
}
