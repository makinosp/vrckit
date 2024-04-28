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
    static let url = "\(baseUrl)/userNotes"

    /// Update user's note
    public static func updateUserNote(
        _ client: APIClientAsync,
        targetUserId: String,
        note: String
    ) async throws -> Result<UserNoteResponse, ErrorResponse> {
        let url = URL(string: url)!
        let userNoteRequest = UserNoteRequest(targetUserId: targetUserId, note: note)
        let requestData = try JSONEncoder().encode(userNoteRequest)
        let response = try await client.VRChatRequest(
            url: url,
            httpMethod: .post,
            cookieKeys: [.auth, .apiKey],
            httpBody: requestData
        )
        return Util.shared.decodeResponse(response.data)
    }
}
