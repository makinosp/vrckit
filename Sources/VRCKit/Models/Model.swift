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

public struct ErrorResponse: Codable, Error {
    public let error: ErrorInfo

    public struct ErrorInfo: Codable {
        public let message: String
        public let statusCode: Int
    }

    init(error: ErrorInfo) {
        self.error = error
    }

    init(message: String) {
        self.error = ErrorInfo(message: message, statusCode: -1)
    }

    var localizedDescription: String { error.message }
}
