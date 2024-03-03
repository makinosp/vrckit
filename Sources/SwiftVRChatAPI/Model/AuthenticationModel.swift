//
//  AuthenticationModel.swift
//  
//
//  Created by makinosp on 2024/02/12.
//

struct ExistsResponse: Codable {
    let userExists: Bool
}

struct VerifyRequest: Codable { 
    let code: String
}

struct VerifyResponse: Codable {
    let verified: Bool
}

public enum TwoFactorAuthType: String {
    case emailotp
    case totp
}

public struct RequiresTwoFactorAuthResponse: Codable {
    let requiresTwoFactorAuth: [String]
}
