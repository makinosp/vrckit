//
//  FriendModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/03.
//

import Foundation

public struct Friend: ProfileElementRepresentable, LocationRepresentable {
    public let bio: String?
    public var bioLinks: SafeDecodingArray<URL>
    public let avatarImageUrl: URL?
    public let avatarThumbnailUrl: URL?
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let platform: UserPlatform
    public let profilePicOverride: URL?
    public let status: UserStatus
    public let statusDescription: String
    public let tags: UserTags
    public let userIcon: URL?
    public let location: String
    public let friendKey: String
}

extension Friend: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        bioLinks = try container.decodeSafeNullableArray(URL.self, forKey: .bioLinks)
        avatarImageUrl = try container.decodeIfPresent(URL.self, forKey: .avatarImageUrl)
        avatarThumbnailUrl = try container.decodeIfPresent(URL.self, forKey: .avatarThumbnailUrl)
        displayName = try container.decode(String.self, forKey: .displayName)
        id = try container.decode(String.self, forKey: .id)
        isFriend = try container.decode(Bool.self, forKey: .isFriend)
        lastLogin = try container.decode(Date.self, forKey: .lastLogin)
        lastPlatform = try container.decode(String.self, forKey: .lastPlatform)
        profilePicOverride = try? container.decodeIfPresent(URL.self, forKey: .profilePicOverride)
        status = try container.decode(UserStatus.self, forKey: .status)
        statusDescription = try container.decode(String.self, forKey: .statusDescription)
        tags = try container.decode(UserTags.self, forKey: .tags)
        userIcon = try? container.decodeIfPresent(URL.self, forKey: .userIcon)
        location = try container.decode(String.self, forKey: .location)
        friendKey = try container.decode(String.self, forKey: .friendKey)
        platform = try container.decode(UserPlatform.self, forKey: .platform)
    }
}

extension Friend {
    private enum CodingKeys: String, CodingKey {
        case bio
        case bioLinks
        case avatarImageUrl = "currentAvatarImageUrl"
        case avatarThumbnailUrl = "currentAvatarThumbnailImageUrl"
        case displayName
        case id
        case isFriend
        case lastLogin
        case lastPlatform
        case profilePicOverride
        case status
        case statusDescription
        case tags
        case userIcon
        case location
        case friendKey
        case platform
    }
}

public struct FriendsLocation: LocationRepresentable {
    public let location: String
    public let friends: [Friend]
}

extension FriendsLocation: Hashable, Identifiable {
    public var id: String { location }
}
