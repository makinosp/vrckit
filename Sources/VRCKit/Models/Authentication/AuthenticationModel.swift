//
//  AuthenticationModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/12.
//

public enum VerifyType: String, Codable, Sendable {
    case emailOtp, totp, otp
}

struct ExistsResponse: Codable, Sendable {
    let userExists: Bool
}

struct VerifyRequest: Codable, Sendable {
    let code: String
}

struct VerifyResponse: Codable, Sendable {
    let verified: Bool
}

struct RequiresTwoFactorAuthResponse: Codable, Sendable {
    let requiresTwoFactorAuth: [VerifyType]

    var requires: VerifyType? {
        requiresTwoFactorAuth.first { [.totp, .emailOtp].contains($0) }
    }
}

struct VerifyAuthTokenResponse: Codable, Sendable {
    let ok: Bool
    let token: String
}
