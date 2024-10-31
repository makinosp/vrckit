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

    public func exists(userId: String) async throws -> Bool {
        let path = "\(authPath)/exists"
        let queryItems = [URLQueryItem(name: "username", value: userId.description)]
        let response = try await client.request(path: path, method: .get, queryItems: queryItems)
        let result: ExistsResponse = try Serializer.shared.decode(response.data)
        return result.userExists
    }

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

    public func verifyAuthToken() async throws -> Bool {
        let response = try await client.request(path: authPath, method: .get)
        let result: VerifyAuthTokenResponse = try Serializer.shared.decode(response.data)
        return result.ok
    }

    public func logout() async throws {
        _ = try await client.request(path: "logout", method: .put)
        await client.cookieManager.deleteCookies()
    }
}
