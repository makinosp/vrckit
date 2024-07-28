//
//  UserPreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public final class UserPreviewService: UserService {
    override public func fetchUser(userId: String) async throws -> UserDetail {
        PreviewDataProvider.shared.userDetails.first { $0.id == userId }!
    }

    override public func updateUser(id: String, editedInfo: EditableUserInfo) async throws -> User {
        PreviewDataProvider.shared.previewUser
    }
}
