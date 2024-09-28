//
//  CommonModels.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/03.
//

import MemberwiseInit

@MemberwiseInit(.public)
public struct ResponseMessage: Codable, Sendable {
    public let message: String
    public let statusCode: Int
}

@MemberwiseInit(.public)
public struct SuccessResponse: Codable, Sendable {
    public let success: ResponseMessage
}

@MemberwiseInit(.public)
public struct ErrorResponse: Codable, Sendable, Error {
    public let error: ResponseMessage
}
