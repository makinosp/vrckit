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

struct UserNoteResponse: Codable, Identifiable {
    let id: String
    let targetUserId: String
    let note: String
    let userId: String
    let createdAt: Date
}
