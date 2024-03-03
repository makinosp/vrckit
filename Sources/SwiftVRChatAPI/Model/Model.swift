//
//  Model.swift
//  
//
//  Created by 夏同光 on 2/23/23.
//

//
// MARK: General Model
//

let domainUrl = "http://localhost:8080"
let baseUrl = "http://localhost:8080"

public struct Response: Codable {
    public let message: String?
    public let status_code: Int?
}
