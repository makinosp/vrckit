//
//  AuthenticationModel.swift
//  
//
//  Created by makinosp on 2024/02/12.
//

public enum TwoFactorAuthType: String, Codable {
    case emailotp, totp, otp
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
    let requiresTwoFactorAuth: [TwoFactorAuthType]
}

public struct VerifyAuthTokenResponse: Codable {
    let ok: Bool
    let token: String
}
