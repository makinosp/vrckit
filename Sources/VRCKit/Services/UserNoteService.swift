//
//  UserNoteService.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

public class UserNoteService: APIService, UserNoteServiceProtocol {
    let path = "userNotes"

    /// Update user's note
    public func updateUserNote(
        targetUserId: String,
        note: String
    ) async throws -> UserNoteResponse {
        let response = try await request(
            userNote: UserNoteRequest(targetUserId: targetUserId, note: note)
        )
        return try await Serializer.shared.decode(response.data)
    }

    public func clearUserNote(targetUserId: String) async throws {
        _ = try await request(userNote: UserNoteRequest(targetUserId: targetUserId, note: ""))
    }

    private func request(userNote: UserNoteRequest) async throws -> APIClient.HTTPResponse {
        let requestData = try await Serializer.shared.encode(userNote)
        return try await client.request(path: path, method: .post, body: requestData)
    }
}
