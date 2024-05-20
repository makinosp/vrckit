//
//  Model.swift
//  
//
//  Created by 夏同光 on 2/23/23.
//

//
// MARK: General Model
//

let domainUrl = "https://api.vrchat.cloud"
let baseUrl = "https://api.vrchat.cloud/api/1"

public struct ResponseMessage: Codable {
    let message: String
    let statusCode: Int
}

public struct SuccessResponse: Codable {
    let success: ResponseMessage
}

public struct ErrorResponse: Codable, Error {
    let error: ResponseMessage

    init(message: String) {
        self.error = ResponseMessage(message: message, statusCode: -1)
    }
}
