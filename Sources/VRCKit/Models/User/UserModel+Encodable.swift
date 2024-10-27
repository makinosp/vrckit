//
//  UserModel+Encodable.swift
//  VRCKit
//
//  Created by makinosp on 2024/10/27.
//

import Foundation

extension User: Encodable {
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)
        try container.encode(activeFriends, forKey: .activeFriends)
        try container.encode(allowAvatarCopying, forKey: .allowAvatarCopying)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encode(bioLinks.wrappedValue, forKey: .bioLinks)
        try container.encode(currentAvatar, forKey: .currentAvatar)
        try container.encodeIfPresent(avatarImageUrl, forKey: .currentAvatarImageUrl)
        try container.encodeIfPresent(avatarThumbnailUrl, forKey: .currentAvatarThumbnailImageUrl)
        if let dateJoined = dateJoined {
            let dateJoinedString = DateFormatter.dateStringFormat.string(from: dateJoined)
            try container.encode(dateJoinedString, forKey: .dateJoined)
        }
        try container.encode(displayName, forKey: .displayName)
        try container.encode(friendKey, forKey: .friendKey)
        try container.encode(friends, forKey: .friends)
        try container.encode(homeLocation, forKey: .homeLocation)
        try container.encode(id, forKey: .id)
        try container.encode(isFriend, forKey: .isFriend)
        try container.encode(lastActivity, forKey: .lastActivity)
        try container.encode(lastLogin, forKey: .lastLogin)
        try container.encode(lastPlatform, forKey: .lastPlatform)
        try container.encode(offlineFriends, forKey: .offlineFriends)
        try container.encode(onlineFriends, forKey: .onlineFriends)
        try container.encode(pastDisplayNames, forKey: .pastDisplayNames)
        try container.encodeIfPresent(profilePicOverride, forKey: .profilePicOverride)
        try container.encode(state, forKey: .state)
        try container.encode(status, forKey: .status)
        try container.encode(statusDescription, forKey: .statusDescription)
        try container.encode(tags, forKey: .tags)
        try container.encode(twoFactorAuthEnabled, forKey: .twoFactorAuthEnabled)
        try container.encodeIfPresent(userIcon, forKey: .userIcon)
        try container.encodeIfPresent(userLanguage, forKey: .userLanguage)
        try container.encodeIfPresent(userLanguageCode, forKey: .userLanguageCode)
        try container.encode(presence, forKey: .presence)
    }
}
