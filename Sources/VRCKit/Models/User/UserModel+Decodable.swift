//
//  UserModel+Decodable.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/02.
//

import Foundation

extension User: Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        activeFriends = try container.decode([String].self, forKey: .activeFriends)
        allowAvatarCopying = try container.decode(Bool.self, forKey: .allowAvatarCopying)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        bioLinks = try container.decodeSafeNullableArray(URL.self, forKey: .bioLinks)
        currentAvatar = try container.decode(String.self, forKey: .currentAvatar)
        avatarImageUrl = try? container.decodeIfPresent(URL.self, forKey: .currentAvatarImageUrl)
        avatarThumbnailUrl = try? container.decodeIfPresent(URL.self, forKey: .currentAvatarThumbnailImageUrl)
        let dateJoinedString = try container.decode(String.self, forKey: .dateJoined)
        dateJoined = DateFormatter.dateStringFormat.date(from: dateJoinedString)
        displayName = try container.decode(String.self, forKey: .displayName)
        friendKey = try container.decode(String.self, forKey: .friendKey)
        friends = try container.decode([String].self, forKey: .friends)
        homeLocation = try container.decode(String.self, forKey: .homeLocation)
        id = try container.decode(User.ID.self, forKey: .id)
        isFriend = try container.decode(Bool.self, forKey: .isFriend)
        lastActivity = try container.decode(Date.self, forKey: .lastActivity)
        lastLogin = try container.decode(Date.self, forKey: .lastLogin)
        lastPlatform = try container.decode(String.self, forKey: .lastPlatform)
        offlineFriends = try container.decode([String].self, forKey: .offlineFriends)
        onlineFriends = try container.decode([String].self, forKey: .onlineFriends)
        pastDisplayNames = try container.decode([DisplayName].self, forKey: .pastDisplayNames)
        profilePicOverride = try? container.decodeIfPresent(URL.self, forKey: .profilePicOverride)
        state = try container.decode(User.State.self, forKey: .state)
        status = try container.decode(UserStatus.self, forKey: .status)
        statusDescription = try container.decode(String.self, forKey: .statusDescription)
        tags = try container.decode(UserTags.self, forKey: .tags)
        twoFactorAuthEnabled = try container.decode(Bool.self, forKey: .twoFactorAuthEnabled)
        userIcon = try? container.decodeIfPresent(URL.self, forKey: .userIcon)
        userLanguage = try container.decodeIfPresent(String.self, forKey: .userLanguage)
        userLanguageCode = try container.decodeIfPresent(String.self, forKey: .userLanguageCode)
        presence = try container.decode(Presence.self, forKey: .presence)
    }
}
