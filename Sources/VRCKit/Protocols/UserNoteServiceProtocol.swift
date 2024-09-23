//
//  UserNoteServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol UserNoteServiceProtocol: Sendable {
    func updateUserNote(targetUserId: String, note: String) async throws -> UserNoteResponse
    func clearUserNote(targetUserId: String) async throws
}
