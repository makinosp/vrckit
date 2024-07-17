//
//  UserModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/02/18.
//

import Foundation

public struct User: Codable, ProfileDetailRepresentable {
    public let activeFriends: [String]
    public let allowAvatarCopying: Bool
    public let bio: String?
    public let bioLinks: [String]?
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
    public let status: Status
    public let statusDescription: String
    public let tags: [String]
    public let twoFactorAuthEnabled: Bool
    public let userIcon: String?
    public let userLanguage: String?
    public let userLanguageCode: String?

    public struct DisplayName: Codable, Hashable {
        public let displayName: String
        public let updatedAt: Date
    }

    /// Defines the User's current status, for example "ask me", "join me" or "offline.
    /// This status is a combined indicator of their online activity and privacy preference.
    public enum Status: String, Codable, CaseIterable {
        case joinMe = "join me"
        case active
        case askMe = "ask me"
        case busy
        case offline
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

extension User.Status: CustomStringConvertible {
    public var description: String {
        switch self {
        case .joinMe:
            "Join Me"
        case .active:
            "Online"
        case .askMe:
            "Ask Me"
        case .busy:
            "Do Not Disturb"
        case .offline:
            "Offline"
        }
    }
}

extension User.Status: Identifiable {
    public var id: Int {
        self.hashValue
    }
}

public struct UpdatedUser: Codable {
    public let bio: String?
    public let statusDescription: String?
}
