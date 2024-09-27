//
//  UserModel+Initializers.swift
//  VRCKit
//
//  Created by makinosp on 2024/09/27.
//

public extension User {
    init(user: User, editedUserInfo: EditableUserInfo) {
        activeFriends = user.activeFriends
        allowAvatarCopying = user.allowAvatarCopying
        bio = editedUserInfo.bio
        bioLinks = SafeDecodingArray(elements: editedUserInfo.bioLinks)
        currentAvatar = user.currentAvatar
        avatarImageUrl = user.avatarImageUrl
        avatarThumbnailUrl = user.avatarThumbnailUrl
        dateJoined = user.dateJoined
        displayName = user.displayName
        friendKey = user.friendKey
        friends = user.friends
        homeLocation = user.homeLocation
        id = user.id
        isFriend = user.isFriend
        lastActivity = user.lastActivity
        lastLogin = user.lastLogin
        lastPlatform = user.lastPlatform
        offlineFriends = user.offlineFriends
        onlineFriends = user.onlineFriends
        pastDisplayNames = user.pastDisplayNames
        profilePicOverride = user.profilePicOverride
        state = user.state
        status = editedUserInfo.status
        statusDescription = editedUserInfo.statusDescription
        tags = UserTags(
            systemTags: user.tags.systemTags,
            languageTags: editedUserInfo.tags.languageTags,
            unknownTags: editedUserInfo.tags.unknownTags
        )
        twoFactorAuthEnabled = user.twoFactorAuthEnabled
        userIcon = user.userIcon
        userLanguage = user.userLanguage
        userLanguageCode = user.userLanguageCode
        presence = user.presence
    }
}
