//
//  UserNoteService.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

import MemberwiseInit

@MemberwiseInit(.public)
public final actor UserNoteService: APIService, UserNoteServiceProtocol {
    public let client: APIClient
    private let path = "userNotes"

    /// Updates the note for a specific user by sending the note to the API.
    /// - Parameters:
    ///   - targetUserId: The ID of the user for whom the note is being updated.
    ///   - note: The content of the note to be added or updated.
    /// - Returns: A `UserNoteResponse` containing the updated note information.
    public func updateUserNote(
        targetUserId: String,
        note: String
    ) async throws -> UserNoteResponse {
        let response = try await request(
            userNote: UserNoteRequest(targetUserId: targetUserId, note: note)
        )
        return try await Serializer.shared.decode(response.data)
    }

    /// Clears the note for a specific user by sending an empty note to the API.
    /// - Parameter targetUserId: The ID of the user whose note is being cleared.
    public func clearUserNote(targetUserId: String) async throws {
        _ = try await request(userNote: UserNoteRequest(targetUserId: targetUserId, note: ""))
    }

    /// Sends a request to update or clear a user note.
    /// - Parameter userNote: The `UserNoteRequest` containing the user ID and note content.
    /// - Returns: The `HTTPResponse` received from the API.
    private func request(userNote: UserNoteRequest) async throws -> APIClient.HTTPResponse {
        let requestData = try await Serializer.shared.encode(userNote)
        return try await client.request(path: path, method: .post, body: requestData)
    }
}
