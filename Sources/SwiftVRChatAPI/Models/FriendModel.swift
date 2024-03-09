//
//  FriendModel.swift
//  
//
//  Created by makinosp on 2024/03/03.
//

import Foundation

public struct Friend: Codable, Hashable, Identifiable {
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
    public let status: String
    public let statusDescription: String
    public let tags: [String]
    public let userIcon: String?
    public let location: String?
    public let friendKey: String?

    public init(
        bio: String?,
        bioLinks: [String]?,
        currentAvatarImageUrl: String,
        currentAvatarThumbnailImageUrl: String,
        developerType: String,
        displayName: String,
        id: String,
        isFriend: Bool,
        lastLogin: Date,
        lastPlatform: String,
        status: String,
        statusDescription: String,
        tags: [String],
        userIcon: String? = nil,
        location: String? = nil,
        friendKey: String? = nil
    ) {
        self.bio = bio
        self.bioLinks = bioLinks
        self.currentAvatarImageUrl = currentAvatarImageUrl
        self.currentAvatarThumbnailImageUrl = currentAvatarThumbnailImageUrl
        self.developerType = developerType
        self.displayName = displayName
        self.id = id
        self.isFriend = isFriend
        self.lastLogin = lastLogin
        self.lastPlatform = lastPlatform
        self.status = status
        self.statusDescription = statusDescription
        self.tags = tags
        self.userIcon = userIcon
        self.location = location
        self.friendKey = friendKey
    }
}
