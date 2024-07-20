//
//  AuthenticationModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/12.
//

public enum VerifyType: String, Codable {
    case emailOtp, totp, otp
}

public struct ExistsResponse: Codable {
    let userExists: Bool
}

public struct VerifyRequest: Codable {
    let code: String
}

public struct VerifyResponse: Codable {
    let verified: Bool
}

public struct RequiresTwoFactorAuthResponse: Codable {
    let requiresTwoFactorAuth: [VerifyType]

    var requires: VerifyType? {
        requiresTwoFactorAuth.first { [.totp, .emailOtp].contains($0) }
    }
}

public struct VerifyAuthTokenResponse: Codable {
    let ok: Bool
    let token: String
}
