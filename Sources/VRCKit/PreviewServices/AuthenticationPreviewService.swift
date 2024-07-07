//
//  AuthenticationPreviewService.swift
//  
//
//  Created by makinosp on 2024/07/06.
//

import Foundation

public class AuthenticationPreviewService: AuthenticationService {
    override public func loginUserInfo() async throws -> UserOrRequires {
        User(
            activeFriends: [],
            allowAvatarCopying: false,
            bio: "This is the demo user.",
            bioLinks: ["https://example.com"],
            currentAvatar: "",
            currentAvatarAssetUrl: "",
            currentAvatarImageUrl: "",
            currentAvatarThumbnailImageUrl: "",
            dateJoined: "2024/07/01",
            displayName: "Demo user",
            friendKey: "",
            friends: [],
            homeLocation: "",
            id: "",
            isFriend: false,
            lastActivity: Date(),
            lastLogin: Date(),
            lastPlatform: "standalonewindows",
            offlineFriends: [],
            onlineFriends: [],
            pastDisplayNames: [],
            profilePicOverride: nil,
            state: .active,
            status: .active,
            statusDescription: "status",
            tags: [],
            twoFactorAuthEnabled: true,
            userIcon: nil,
            userLanguage: nil,
            userLanguageCode: nil
        )
    }
}
