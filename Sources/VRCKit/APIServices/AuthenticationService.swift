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
extension VerifyType: UserOrRequires {}

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
        let result: ExistsResponse = try Util.shared.decode(response.data)
        return result.userExists
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
        do {
            defer { client.updateCookies() }
            let user: User = try Util.shared.decode(response.data)
            return user
        } catch let error as DecodingError {
            let result: RequiresTwoFactorAuthResponse = try Util.shared.decode(response.data)
            guard let requires = result.requires else {
                throw VRCKitError.unexpectedError
            }
            return requires
        }
    }

    /// Verify 2FA With TOTP or Email OTP
    public static func verify2FA(
        _ client: APIClient,
        verifyType: VerifyType,
        code: String
    ) async throws -> Bool {
        let requestData = try Util.shared.encode(VerifyRequest(code: code))
        let response = try await client.request(
            url: URL(string: "\(auth2FAUrl)/\(verifyType.rawValue.lowercased())/verify")!,
            httpMethod: .post,
            cookieKeys: [.auth, .twoFactorAuth],
            httpBody: requestData
        )
        let result: VerifyResponse = try Util.shared.decode(response.data)
        client.updateCookies()
        return result.verified
    }

    /// Verify Auth Token
    public static func verifyAuthToken(_ client: APIClient) async throws -> Bool {
        let response = try await client.request(
            url: URL(string: authUrl)!,
            httpMethod: .get,
            cookieKeys: [.auth]
        )
        let result: VerifyAuthTokenResponse = try Util.shared.decode(response.data)
        client.updateCookies()
        return result.ok
    }

    /// Logout
    public static func logout(_ client: APIClient) async throws {
        let _ = try await client.request(
            url: URL(string: "\(baseUrl)/logout")!,
            httpMethod: .put,
            cookieKeys: [.auth]
        )
        client.deleteCookies()
    }
}
