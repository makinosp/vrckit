//
//  AgeVerificationModel.swift
//  VRCKit
//
//  Created by makinosp on 2025/02/26.
//

public enum AgeVerificationStatus: String, Codable, Sendable {
    case hidden
    case verified
    case over18 = "18+"
}
