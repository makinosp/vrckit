//
//  AuthenticationServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol AuthenticationServiceProtocol: Sendable {

    /// Check if a user exists by their user ID.
    /// - Parameter userId: The ID of the user to check.
    /// - Returns: A boolean indicating if the user exists.
    func exists(userId: String) async throws -> Bool

    /// Fetches the authenticated user's information or determines if 2FA verification is required.
    /// - Returns: An `Either<User, VerifyType>` result.
    /// - Throws: An error if the request fails or if the response cannot be decoded.
    ///   If an unexpected decoding issue occurs,it throws `VRCKitError.unexpected`.
    func loginUserInfo() async throws -> Either<User, VerifyType>

    /// Verifies 2-factor authentication using either TOTP or Email OTP.
    /// - Parameters:
    ///   - verifyType: The type of verification (TOTP or Email OTP).
    ///   - code: The 6-digit verification code.
    /// - Returns: A boolean indicating if verification was successful.
    func verify2FA(verifyType: VerifyType, code: String) async throws -> Bool

    /// Verifies the user's authentication token.
    /// - Returns: A boolean indicating if the token is valid.
    func verifyAuthToken() async throws -> Bool

    /// Logs out the user and deletes cookies.
    func logout() async throws
}
