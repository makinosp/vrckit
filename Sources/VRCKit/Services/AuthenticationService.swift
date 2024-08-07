//
//  AuthenticationService.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

public class AuthenticationService: APIService, AuthenticationServiceProtocol {
    private let authPath = "auth"

    /// Check User Exists
    public func isExists(userId: String) async throws -> Bool {
        let path = "\(authPath)/exists"
        let queryItems = [URLQueryItem(name: "username", value: userId.description)]
        let response = try await client.request(path: path, method: .get, queryItems: queryItems)
        let result: ExistsResponse = try Serializer.shared.decode(response.data)
        return result.userExists
    }

    /// Login and/or Get Current User Info
    public func loginUserInfo() async throws -> UserOrRequires {
        let path = "\(authPath)/user"
        let response = try await client.request(path: path, method: .get, basic: true)
        do {
            let user: User = try Serializer.shared.decode(response.data)
            return user
        } catch _ as DecodingError {
            let result: RequiresTwoFactorAuthResponse = try Serializer.shared.decode(response.data)
            guard let requires = result.requires else {
                throw VRCKitError.unexpectedError
            }
            return requires
        }
    }

    /// Verify 2FA With TOTP or Email OTP
    public func verify2FA(verifyType: VerifyType, code: String) async throws -> Bool {
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
    public func verifyAuthToken() async throws -> Bool {
        let response = try await client.request(path: authPath, method: .get)
        let result: VerifyAuthTokenResponse = try Serializer.shared.decode(response.data)
        return result.ok
    }

    /// Logout
    public func logout() async throws {
        _ = try await client.request(path: "logout", method: .put)
        client.cookieManager.deleteCookies()
    }
}
