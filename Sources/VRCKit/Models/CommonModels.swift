//
//  CommonModels.swift
//  VRCKit
//
//  Created by makinosp on 2024/08/03.
//

public struct ResponseMessage: Codable {
    let message: String
    let statusCode: Int
}

public struct SuccessResponse: Codable {
    let success: ResponseMessage
}

public struct ErrorResponse: Codable, Error {
    let error: ResponseMessage
}
