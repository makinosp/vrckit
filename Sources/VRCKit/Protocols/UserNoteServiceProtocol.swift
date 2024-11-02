//
//  UserNoteServiceProtocol.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public protocol UserNoteServiceProtocol: Sendable {
    /// Updates the note for a specific user by sending the note to the API.
    /// - Parameters:
    ///   - targetUserId: The ID of the user for whom the note is being updated.
    ///   - note: The content of the note to be added or updated.
    /// - Returns: A `UserNoteResponse` containing the updated note information.
    func updateUserNote(targetUserId: String, note: String) async throws -> UserNoteResponse

    /// Clears the note for a specific user by sending an empty note to the API.
    /// - Parameter targetUserId: The ID of the user whose note is being cleared.
    func clearUserNote(targetUserId: String) async throws
}
