//
//  UserModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

public struct User: ProfileDetailRepresentable {
    public let activeFriends: [String]
    public let allowAvatarCopying: Bool
    public let bio: String?
    public var bioLinks: SafeDecodingArray<URL>
    public let currentAvatar: String
    public let currentAvatarAssetUrl: String
    public let currentAvatarImageUrl: String?
    public let currentAvatarThumbnailImageUrl: String?
    public let dateJoined: String
    public let displayName: String
    public let friendKey: String
    public let friends: [String]
    public let homeLocation: String
    public let id: String
    public let isFriend: Bool
    public let lastActivity: Date
    public let lastLogin: Date
    public let lastPlatform: String
    public let offlineFriends: [String]
    public let onlineFriends: [String]
    public let pastDisplayNames: [DisplayName]
    public let profilePicOverride: String?
    public let state: State
    public let status: UserStatus
    public let statusDescription: String
    public let tags: [Tag]
    public let twoFactorAuthEnabled: Bool
    public let userIcon: String?
    public let userLanguage: String?
    public let userLanguageCode: String?

    public struct DisplayName: Codable, Hashable {
        public let displayName: String
        public let updatedAt: Date
    }

    public enum State: String, Codable {
        /// User is online in VRChat
        case online
        /// User is online, but not in VRChat
        case active
        /// User is offline
        case offline
    }
}

extension User: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        activeFriends = try container.decode([String].self, forKey: .activeFriends)
        allowAvatarCopying = try container.decode(Bool.self, forKey: .allowAvatarCopying)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        bioLinks = try container.decodeIfPresent(
            SafeDecodingArray<URL>.self,
            forKey: .bioLinks
        ) ?? SafeDecodingArray()
        currentAvatar = try container.decode(String.self, forKey: .currentAvatar)
        currentAvatarAssetUrl = try container.decode(String.self, forKey: .currentAvatarAssetUrl)
        currentAvatarImageUrl = try container.decodeIfPresent(String.self, forKey: .currentAvatarImageUrl)
        currentAvatarThumbnailImageUrl = try container.decodeIfPresent(
            String.self,
            forKey: .currentAvatarThumbnailImageUrl
        )
        dateJoined = try container.decode(String.self, forKey: .dateJoined)
        displayName = try container.decode(String.self, forKey: .displayName)
        friendKey = try container.decode(String.self, forKey: .friendKey)
        friends = try container.decode([String].self, forKey: .friends)
        homeLocation = try container.decode(String.self, forKey: .homeLocation)
        id = try container.decode(String.self, forKey: .id)
        isFriend = try container.decode(Bool.self, forKey: .isFriend)
        lastActivity = try container.decode(Date.self, forKey: .lastActivity)
        lastLogin = try container.decode(Date.self, forKey: .lastLogin)
        lastPlatform = try container.decode(String.self, forKey: .lastPlatform)
        offlineFriends = try container.decode([String].self, forKey: .offlineFriends)
        onlineFriends = try container.decode([String].self, forKey: .onlineFriends)
        pastDisplayNames = try container.decode([User.DisplayName].self, forKey: .pastDisplayNames)
        profilePicOverride = try container.decodeIfPresent(String.self, forKey: .profilePicOverride)
        state = try container.decode(User.State.self, forKey: .state)
        status = try container.decode(UserStatus.self, forKey: .status)
        statusDescription = try container.decode(String.self, forKey: .statusDescription)
        tags = try container.decode([Tag].self, forKey: .tags)
        twoFactorAuthEnabled = try container.decode(Bool.self, forKey: .twoFactorAuthEnabled)
        userIcon = try container.decodeIfPresent(String.self, forKey: .userIcon)
        userLanguage = try container.decodeIfPresent(String.self, forKey: .userLanguage)
        userLanguageCode = try container.decodeIfPresent(String.self, forKey: .userLanguageCode)
    }
}

public struct UpdatedUser: Codable {
    public let bio: String?
    public let statusDescription: String?
}
