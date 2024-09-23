//
//  AuthenticationServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol UserOrRequires: Sendable {}
extension User: UserOrRequires {}
extension VerifyType: UserOrRequires {}

public protocol AuthenticationServiceProtocol {
    func isExists(userId: String) async throws -> Bool
    func loginUserInfo() async throws -> UserOrRequires
    func verify2FA(verifyType: VerifyType, code: String) async throws -> Bool
    func verifyAuthToken() async throws -> Bool
    func logout() async throws
}
