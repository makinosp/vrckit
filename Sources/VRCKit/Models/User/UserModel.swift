//
//  UserModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct User: Sendable, ProfileDetailRepresentable {
    public let activeFriends: [String]
    public let allowAvatarCopying: Bool
    public let bio: String?
    public var bioLinks: SafeDecodingArray<URL>
    public let currentAvatar: String
    public let avatarImageUrl: URL?
    public let avatarThumbnailUrl: URL?
    public let dateJoined: Date?
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
    public let profilePicOverride: URL?
    public let state: State
    public let status: UserStatus
    public let statusDescription: String
    public let tags: UserTags
    public let twoFactorAuthEnabled: Bool
    public let userIcon: URL?
    public let userLanguage: String?
    public let userLanguageCode: String?
    public let presence: Presence

    public enum State: String, Codable, Sendable {
        /// User is online in VRChat
        case online
        /// User is online, but not in VRChat
        case active
        /// User is offline
        case offline
    }
}

public extension User {
    var platform: UserPlatform { presence.platform }
}

public extension User {
    var url: URL? {
        URL(string: [Const.homeBaseUrl, "user", id].joined(separator: "/"))
    }
}

@MemberwiseInit(.public)
public struct DisplayName: Codable, Sendable, Hashable {
    public let displayName: String
    public let updatedAt: Date
}
