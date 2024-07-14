//
//  UserPreviewService.swift
//  
//
//  Created by makinosp on 2024/07/14.
//

import Foundation

public final class UserPreviewService: UserService {
    override public func fetchUser(userId: String) async throws -> UserDetail {
        UserDetail(
            bio: "Demo",
            bioLinks: [],
            currentAvatarImageUrl: nil,
            currentAvatarThumbnailImageUrl: nil,
            displayName: "DemoUser",
            id: UUID().uuidString,
            isFriend: true,
            lastLogin: Date(),
            lastPlatform: "windows",
            profilePicOverride: nil,
            state: .active,
            status: .active,
            statusDescription: "Demo",
            tags: [],
            userIcon: "https://ul.h3z.jp/9gGIcerr.png",
            location: "",
            friendKey: "",
            dateJoined: "",
            note: "",
            lastActivity: Date()
        )
    }
}
