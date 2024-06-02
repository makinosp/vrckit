//
//  UserDetailModel.swift
//
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

public struct UserDetail: Codable, UserDetailRepresentable {
    public let bio: String?
    public let bioLinks: [String]?
    public let currentAvatarImageUrl: String
    public let currentAvatarThumbnailImageUrl: String
    public let developerType: String
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let profilePicOverride: String
    public let status: Status
    public let statusDescription: String
    public let tags: [String]
    public let userIcon: String
    public let location: String
    public let friendKey: String
    public let dateJoined: String
    public var note: String
    public let lastActivity: Date

    public var thumbnailUrl: String {
        currentAvatarThumbnailImageUrl.hasSuffix("256")
        ? String(currentAvatarThumbnailImageUrl.dropLast(3)) + "512"
        : currentAvatarImageUrl
    }

    // Initializer to convert from Friend struct to UserDetail struct
    public init(friend: Friend) {
        bio = friend.bio
        bioLinks = friend.bioLinks
        currentAvatarImageUrl = friend.currentAvatarImageUrl
        currentAvatarThumbnailImageUrl = friend.currentAvatarThumbnailImageUrl
        developerType = friend.developerType
        displayName = friend.displayName
        id = friend.id
        isFriend = friend.isFriend
        lastLogin = friend.lastLogin
        lastPlatform = friend.lastPlatform
        profilePicOverride = friend.profilePicOverride
        status = friend.status
        statusDescription = friend.statusDescription
        tags = friend.tags
        userIcon = friend.userIcon
        location = friend.location
        friendKey = friend.friendKey

        // Set initial values for properties specific to UserDetail struct
        dateJoined = ""
        note = ""
        lastActivity = Date()
    }

    public var friend: Friend {
        Friend(
            bio: bio,
            bioLinks: bioLinks,
            currentAvatarImageUrl: currentAvatarImageUrl,
            currentAvatarThumbnailImageUrl: currentAvatarThumbnailImageUrl,
            developerType: developerType,
            displayName: displayName,
            id: id,
            isFriend: isFriend,
            lastLogin: lastLogin,
            lastPlatform: lastPlatform,
            profilePicOverride: profilePicOverride,
            status: status,
            statusDescription: statusDescription,
            tags: tags,
            userIcon: userIcon,
            location: location,
            friendKey: friendKey
        )
    }
}
