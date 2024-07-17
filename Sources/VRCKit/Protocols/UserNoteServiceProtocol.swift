//
//  UserNoteServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol UserNoteServiceProtocol {
    func updateUserNote(targetUserId: String, note: String) async throws -> UserNoteResponse
}
