//
//  FriendModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/03.
//

import Foundation

extension Friend: ProfileElementRepresentable, LocationRepresentable {}

public struct Friend {
    public let bio: String?
    public var bioLinks: SafeDecodingArray<URL>
    public let currentAvatarImageUrl: String?
    public let currentAvatarThumbnailImageUrl: String?
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let profilePicOverride: String?
    public let status: UserStatus
    public let statusDescription: String
    public let tags: [Tag]
    public let userIcon: String?
    public let location: String
    public let friendKey: String
}

extension Friend: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.bio = try container.decodeIfPresent(String.self, forKey: .bio)
        self.bioLinks = try container.decodeIfPresent(
            SafeDecodingArray<URL>.self,
            forKey: .bioLinks
        ) ?? SafeDecodingArray(elements: [])
        self.currentAvatarImageUrl = try container.decodeIfPresent(String.self, forKey: .currentAvatarImageUrl)
        self.currentAvatarThumbnailImageUrl = try container.decodeIfPresent(
            String.self,
            forKey: .currentAvatarThumbnailImageUrl
        )
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.id = try container.decode(String.self, forKey: .id)
        self.isFriend = try container.decode(Bool.self, forKey: .isFriend)
        self.lastLogin = try container.decode(Date.self, forKey: .lastLogin)
        self.lastPlatform = try container.decode(String.self, forKey: .lastPlatform)
        self.profilePicOverride = try container.decodeIfPresent(String.self, forKey: .profilePicOverride)
        self.status = try container.decode(UserStatus.self, forKey: .status)
        self.statusDescription = try container.decode(String.self, forKey: .statusDescription)
        self.tags = try container.decode([Tag].self, forKey: .tags)
        self.userIcon = try container.decodeIfPresent(String.self, forKey: .userIcon)
        self.location = try container.decode(String.self, forKey: .location)
        self.friendKey = try container.decode(String.self, forKey: .friendKey)
    }
}

extension FriendsLocation: LocationRepresentable {}

public struct FriendsLocation: Identifiable, Hashable {
    public let location: String
    public let friends: [Friend]
    public var id: String { location }
}
