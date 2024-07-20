//
//  AuthenticationModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/12.
//

public enum VerifyType: String, Codable {
    case emailOtp, totp, otp
}

struct ExistsResponse: Codable {
    let userExists: Bool
}

struct VerifyRequest: Codable {
    let code: String
}

struct VerifyResponse: Codable {
    let verified: Bool
}

struct RequiresTwoFactorAuthResponse: Codable {
    let requiresTwoFactorAuth: [VerifyType]

    var requires: VerifyType? {
        requiresTwoFactorAuth.first { [.totp, .emailOtp].contains($0) }
    }
}

struct VerifyAuthTokenResponse: Codable {
    let ok: Bool
    let token: String
}
