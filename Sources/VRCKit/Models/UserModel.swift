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

    public struct Presence: Codable, Hashable {
        public let groups: [String]
        public let id: String
        public let instance: String
        public let instanceType: String
        public let platform: UserPlatform
        public let status: UserStatus
        public let travelingToInstance: String
        public let travelingToWorld: String
        public let world: String
    }
}

public extension User {
    var platform: UserPlatform {
        presence.platform
    }
    var url: URL? {
        URL(string: [Const.homeBaseUrl, "user", id].joined(separator: "/"))
    }
}

extension User.Presence {
    init() {
        groups = []
        id = UUID().uuidString
        instance = ""
        instanceType = ""
        platform = .blank
        status = .offline
        travelingToInstance = ""
        travelingToWorld = ""
        world = ""
    }
}
