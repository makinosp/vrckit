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

    public func updateUserNote(
        targetUserId: String,
        note: String
    ) async throws -> UserNoteResponse {
        let response = try await request(
            userNote: UserNoteRequest(targetUserId: targetUserId, note: note)
        )
        return try Serializer.shared.decode(response.data)
    }

    public func clearUserNote(targetUserId: String) async throws {
        _ = try await request(userNote: UserNoteRequest(targetUserId: targetUserId, note: ""))
    }

    /// Sends a request to update or clear a user note.
    /// - Parameter userNote: The `UserNoteRequest` containing the user ID and note content.
    /// - Returns: The `HTTPResponse` received from the API.
    private func request(userNote: UserNoteRequest) async throws -> APIClient.HTTPResponse {
        let requestData = try Serializer.shared.encode(userNote)
        return try await client.request(path: path, method: .post, body: requestData)
    }
}
