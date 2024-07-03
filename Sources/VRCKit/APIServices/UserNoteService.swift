//
//  UserNoteService.swift
//
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

@available(macOS 12.0, *)
@available(iOS 15.0, *)
public struct UserNoteService {
    static let path = "userNotes"

    /// Update user's note
    public static func updateUserNote(
        _ client: APIClient,
        targetUserId: String,
        note: String
    ) async throws -> UserNoteResponse {
        let userNoteRequest = UserNoteRequest(targetUserId: targetUserId, note: note)
        let requestData = try Util.shared.encode(userNoteRequest)
        let response = try await client.request(path: path, httpMethod: .post, httpBody: requestData)
        return try Util.shared.decode(response.data)
    }
}
