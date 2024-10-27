//
//  AuthenticationService.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public final actor AuthenticationService: APIService, AuthenticationServiceProtocol {
    public let client: APIClient
    private let authPath = "auth"

    /// Check if a user exists by their user ID.
    /// - Parameter userId: The ID of the user to check.
    /// - Returns: A boolean indicating if the user exists.
    public func exists(userId: String) async throws -> Bool {
        let path = "\(authPath)/exists"
        let queryItems = [URLQueryItem(name: "username", value: userId.description)]
        let response = try await client.request(path: path, method: .get, queryItems: queryItems)
        let result: ExistsResponse = try Serializer.shared.decode(response.data)
        return result.userExists
    }

    /// Logs in and/or fetches the current user's information.
    /// - Returns: A `User` object or a `RequiresTwoFactorAuthResponse` if 2FA is required.
    public func loginUserInfo() async throws -> Either<User, VerifyType> {
        let path = "\(authPath)/user"
        let response = try await client.request(path: path, method: .get, basic: true)
        do {
            let user: User = try Serializer.shared.decode(response.data)
            return .left(user)
        } catch _ as DecodingError {
            let result: RequiresTwoFactorAuthResponse = try Serializer.shared.decode(response.data)
            guard let requires = result.requires else {
                throw VRCKitError.unexpected
            }
            return .right(requires)
        }
    }

    /// Verifies 2-factor authentication using either TOTP or Email OTP.
    /// - Parameters:
    ///   - verifyType: The type of verification (TOTP or Email OTP).
    ///   - code: The 6-digit verification code.
    /// - Returns: A boolean indicating if verification was successful.
    public func verify2FA(verifyType: VerifyType, code: String) async throws -> Bool {
        guard code.count == 6 else { throw VRCKitError.invalidRequest("Code must be 6 digits") }
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

    /// Verifies the user's authentication token.
    /// - Returns: A boolean indicating if the token is valid.
    public func verifyAuthToken() async throws -> Bool {
        let response = try await client.request(path: authPath, method: .get)
        let result: VerifyAuthTokenResponse = try Serializer.shared.decode(response.data)
        return result.ok
    }

    /// Logs out the user and deletes cookies.
    public func logout() async throws {
        _ = try await client.request(path: "logout", method: .put)
        await client.cookieManager.deleteCookies()
    }
}
