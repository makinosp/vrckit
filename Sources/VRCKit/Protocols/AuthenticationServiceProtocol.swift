//
//  AuthenticationServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol AuthenticationServiceProtocol: Sendable {
    func exists(userId: String) async throws -> Bool
    func loginUserInfo() async throws -> Either<User, VerifyType>
    func verify2FA(verifyType: VerifyType, code: String) async throws -> Bool
    func verifyAuthToken() async throws -> Bool
    func logout() async throws
}
