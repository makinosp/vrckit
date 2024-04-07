//
//  UserNoteModel.swift
//  
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

struct UserNoteRequest: Codable {
    var targetUserId: String
    var note: String
}

public struct UserNoteResponse: Codable, Identifiable {
    public let id: String
    public let targetUserId: String
    public let note: String
    public let userId: String
    public let createdAt: Date
}
