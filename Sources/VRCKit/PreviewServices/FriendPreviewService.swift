//
//  FriendPreviewService.swift
//  VRCKit
//
//  Created by makinosp on 2024/07/07.
//

public final class FriendPreviewService: FriendService {
    override public func fetchFriends(offset: Int, n: Int, offline: Bool) async throws -> [Friend] {
        offline ? PreviewDataProvider.shared.offlineFriends : PreviewDataProvider.shared.onlineFriends
    }
}
