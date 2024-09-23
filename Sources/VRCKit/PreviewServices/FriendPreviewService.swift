//
//  FriendPreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/07.
//

public final actor FriendPreviewService: APIService, FriendServiceProtocol {
    let client: APIClient

    public init(client: APIClient) {
        self.client = client
    }

    public func fetchFriends(offset: Int, n: Int, offline: Bool) async throws -> [Friend] {
        offline ? PreviewDataProvider.shared.offlineFriends : PreviewDataProvider.shared.onlineFriends
    }

    public func fetchFriends(count: Int, offline: Bool) async throws -> [Friend] {
        offline ? PreviewDataProvider.shared.offlineFriends : PreviewDataProvider.shared.onlineFriends
    }

    public func unfriend(id: String) async throws {}
}
