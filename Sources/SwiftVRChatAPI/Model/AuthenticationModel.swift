//
//  AuthenticationModel.swift
//  
//
//  Created by makinosp on 2024/02/12.
//

struct AuthResponse: Codable { 
    let ok: Bool
    let token: String
}

struct ExistsResponse: Codable {
    let userExists: Bool
}

struct VerifyCode: Codable { 
    let code: String
}

struct VerifyResponse: Codable {
    let verified: Bool
}
