//
//  UserDetailModel+Decodable.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/02.
//

import Foundation

extension UserDetail: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        ageVerificationStatus = try container.decode(AgeVerificationStatus.self, forKey: .ageVerificationStatus)
        ageVerified = try container.decode(Bool.self, forKey: .ageVerified)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        bioLinks = try container.decodeSafeNullableArray(URL.self, forKey: .bioLinks)
        avatarImageUrl = try? container.decodeIfPresent(URL.self, forKey: .currentAvatarImageUrl)
        avatarThumbnailUrl = try? container.decodeIfPresent(URL.self, forKey: .currentAvatarThumbnailImageUrl)
        displayName = try container.decode(String.self, forKey: .displayName)
        id = try container.decode(UserDetail.ID.self, forKey: .id)
        isFriend = try container.decode(Bool.self, forKey: .isFriend)
        lastLogin = try container.decode(Date.self, forKey: .lastLogin)
        lastPlatform = try container.decode(String.self, forKey: .lastPlatform)
        profilePicOverride = try? container.decodeIfPresent(URL.self, forKey: .profilePicOverride)
        state = try container.decode(User.State.self, forKey: .state)
        status = try container.decode(UserStatus.self, forKey: .status)
        statusDescription = try container.decode(String.self, forKey: .statusDescription)
        tags = try container.decode(UserTags.self, forKey: .tags)
        userIcon = try? container.decodeIfPresent(URL.self, forKey: .userIcon)
        location = try container.decode(Location.self, forKey: .location)
        friendKey = try container.decode(String.self, forKey: .friendKey)
        let dateJoinedString = try container.decode(String.self, forKey: .dateJoined)
        dateJoined = DateFormatter.dateStringFormat.date(from: dateJoinedString)
        note = try container.decode(String.self, forKey: .note)
        lastActivity = try container.decode(Date.self, forKey: .lastActivity)
        platform = try container.decode(UserPlatform.self, forKey: .platform)
    }
}
