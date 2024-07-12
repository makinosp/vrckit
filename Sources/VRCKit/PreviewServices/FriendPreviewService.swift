//
//  FriendPreviewService.swift
//
//
//  Created by makinosp on 2024/07/07.
//

import Foundation

public class FriendPreviewService: FriendService {
    override public func fetchFriends(offset: Int, n: Int, offline: Bool) async throws -> [Friend] {
        let friend = Friend(
            bio: nil,
            bioLinks: nil,
            currentAvatarImageUrl: nil,
            currentAvatarThumbnailImageUrl: nil,
            displayName: "Dummy friend",
            id: "usr_\(UUID().uuidString)",
            isFriend: true,
            lastLogin: Date(),
            lastPlatform: "standalonewindows",
            profilePicOverride: nil,
            status: .active,
            statusDescription: "",
            tags: [],
            userIcon: nil,
            location: "private",
            friendKey: ""
        )
        return [friend]
    }
}
