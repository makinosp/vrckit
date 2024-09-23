//
//  CommonModels.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/03.
//

public struct ResponseMessage: Codable, Sendable {
    let message: String
    let statusCode: Int
}

public struct SuccessResponse: Codable, Sendable {
    let success: ResponseMessage
}

public struct ErrorResponse: Codable, Sendable, Error {
    let error: ResponseMessage
}
