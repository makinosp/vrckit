//
//  UserNoteService.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public class UserNoteService: APIService, UserNoteServiceProtocol {
    let path = "userNotes"

    /// Update user's note
    public func updateUserNote(
        targetUserId: String,
        note: String
    ) async throws -> UserNoteResponse {
        let userNoteRequest = UserNoteRequest(targetUserId: targetUserId, note: note)
        let requestData = try Serializer.shared.encode(userNoteRequest)
        let response = try await client.request(path: path, method: .post, body: requestData)
        return try Serializer.shared.decode(response.data)
    }
}