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
    public let message: String
    public let statusCode: Int
}

public struct ErrorResponse: Codable, Error {
    public let error: ResponseMessage

    init(message: String) {
        self.error = ResponseMessage(message: message, statusCode: -1)
    }

    var localizedDescription: String { error.message }
}
