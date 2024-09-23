//
//  UserNotePreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

import Foundation

public final actor UserNotePreviewService: APIService, UserNoteServiceProtocol {
    let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }

    public func updateUserNote(
        targetUserId: String,
        note: String
    ) async throws -> UserNoteResponse {
        UserNoteResponse(
            id: UUID().uuidString,
            targetUserId: targetUserId,
            note: note,
            userId: UUID().uuidString,
            createdAt: Date()
        )
    }

    public func clearUserNote(targetUserId: String) async throws {}
}
