//
//  UserNotePreviewService.swift
//
//
//  Created by makinosp on 2024/07/14.
//

import Foundation

public final class UserNotePreviewService: UserNoteService {
    override public func updateUserNote(
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
}
