//
//  UserNoteModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

import Foundation
import MemberwiseInit

struct UserNoteRequest: Codable, Sendable {
    var targetUserId: String
    var note: String
}

@MemberwiseInit(.public)
public struct UserNoteResponse: Codable, Sendable, Identifiable {
    public let id: String
    public let targetUserId: String
    public let note: String
    public let userId: String
    public let createdAt: Date
}
