//
//  UserPreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/14.
//

public final actor UserPreviewService: APIService, UserServiceProtocol {
    let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }

    public func fetchUser(userId: String) async throws -> UserDetail {
        PreviewDataProvider.shared.userDetails.first { $0.id == userId }!
    }

    public func updateUser(id: String, editedInfo: EditableUserInfo) async throws {}
}
