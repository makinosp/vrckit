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
    private static let authPath = "auth"

    /// Check User Exists
    public static func isExists(_ client: APIClient, userId: String) async throws -> Bool {
        let path = "\(authPath)/exists"
        let queryItems = [URLQueryItem(name: "username", value: userId.description)]
        let response = try await client.request(path: path, method: .get, queryItems: queryItems)
        let result: ExistsResponse = try Serializer.shared.decode(response.data)
        return result.userExists
    }

    /// Login and/or Get Current User Info
    public static func loginUserInfo(
        _ client: APIClient
    ) async throws -> UserOrRequires {
        let path = "\(authPath)/user"
        let response = try await client.request(path: path, method: .get, basic: true)
        do {
            let user: User = try Serializer.shared.decode(response.data)
            return user
        } catch let error as DecodingError {
            let result: RequiresTwoFactorAuthResponse = try Serializer.shared.decode(response.data)
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
        let path = "\(authPath)/twofactorauth/\(verifyType.rawValue.lowercased())/verify"
        let requestData = try Serializer.shared.encode(VerifyRequest(code: code))
        let response = try await client.request(
            path: path,
            method: .post,
            body: requestData
        )
        let result: VerifyResponse = try Serializer.shared.decode(response.data)
        return result.verified
    }

    /// Verify Auth Token
    public static func verifyAuthToken(_ client: APIClient) async throws -> Bool {
        let response = try await client.request(path: authPath, method: .get)
        let result: VerifyAuthTokenResponse = try Serializer.shared.decode(response.data)
        return result.ok
    }

    /// Logout
    public static func logout(_ client: APIClient) async throws {
        _ = try await client.request(path: "logout", method: .put)
        client.cookieManager.deleteCookies()
    }
}
