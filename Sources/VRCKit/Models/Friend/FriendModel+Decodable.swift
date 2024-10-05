//
//  Friend+Decodable.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/02.
//

import Foundation

extension Friend: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        bioLinks = try container.decodeSafeNullableArray(URL.self, forKey: .bioLinks)
        avatarImageUrl = try container.decodeIfPresent(URL.self, forKey: .currentAvatarImageUrl)
        avatarThumbnailUrl = try container.decodeIfPresent(URL.self, forKey: .currentAvatarThumbnailImageUrl)
        displayName = try container.decode(String.self, forKey: .displayName)
        id = try container.decode(Friend.ID.self, forKey: .id)
        isFriend = try container.decode(Bool.self, forKey: .isFriend)
        lastLogin = try container.decode(Date.self, forKey: .lastLogin)
        lastPlatform = try container.decode(String.self, forKey: .lastPlatform)
        profilePicOverride = try? container.decodeIfPresent(URL.self, forKey: .profilePicOverride)
        status = try container.decode(UserStatus.self, forKey: .status)
        statusDescription = try container.decode(String.self, forKey: .statusDescription)
        tags = try container.decode(UserTags.self, forKey: .tags)
        userIcon = try? container.decodeIfPresent(URL.self, forKey: .userIcon)
        location = try container.decode(Location.self, forKey: .location)
        friendKey = try container.decode(String.self, forKey: .friendKey)
        platform = try container.decode(UserPlatform.self, forKey: .platform)
    }
}

extension Friend {
    private enum CodingKeys: String, CodingKey {
        case bio
        case bioLinks
        case currentAvatarImageUrl
        case currentAvatarThumbnailImageUrl
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
