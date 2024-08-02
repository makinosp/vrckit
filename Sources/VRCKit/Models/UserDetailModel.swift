//
//  UserDetailModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

extension UserDetail: ProfileDetailRepresentable, LocationRepresentable {}

public typealias Tag = String

public struct UserDetail {
    public var bio: String?
    public var bioLinks: [String]
    public let currentAvatarImageUrl: String?
    public let currentAvatarThumbnailImageUrl: String?
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let profilePicOverride: String?
    public let state: User.State
    public let status: UserStatus
    public var statusDescription: String
    public var tags: [Tag]
    public let userIcon: String?
    public let location: String
    public let friendKey: String
    public let dateJoined: String
    public var note: String
    public let lastActivity: Date
}

extension UserDetail: Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        bioLinks = try container.decodeIfPresent([String].self, forKey: .bioLinks) ?? []
        currentAvatarImageUrl = try container.decodeIfPresent(String.self, forKey: .currentAvatarImageUrl)
        currentAvatarThumbnailImageUrl = try container.decodeIfPresent(
            String.self,
            forKey: .currentAvatarThumbnailImageUrl
        )
        displayName = try container.decode(String.self, forKey: .displayName)
        id = try container.decode(String.self, forKey: .id)
        isFriend = try container.decode(Bool.self, forKey: .isFriend)
        lastLogin = try container.decode(Date.self, forKey: .lastLogin)
        lastPlatform = try container.decode(String.self, forKey: .lastPlatform)
        profilePicOverride = try container.decodeIfPresent(String.self, forKey: .profilePicOverride)
        state = try container.decode(User.State.self, forKey: .state)
        status = try container.decode(UserStatus.self, forKey: .status)
        statusDescription = try container.decode(String.self, forKey: .statusDescription)
        tags = try container.decode([Tag].self, forKey: .tags)
        userIcon = try container.decodeIfPresent(String.self, forKey: .userIcon)
        location = try container.decode(String.self, forKey: .location)
        friendKey = try container.decode(String.self, forKey: .friendKey)
        dateJoined = try container.decode(String.self, forKey: .dateJoined)
        note = try container.decode(String.self, forKey: .note)
        lastActivity = try container.decode(Date.self, forKey: .lastActivity)
    }
}

public struct EditableUserInfo: Codable, Hashable {
    public var bio: String
    public var bioLinks: [URL]
    public var status: UserStatus
    public var statusDescription: String
    public var tags: [Tag]

    public init(detail: any ProfileDetailRepresentable) {
        self.bio = detail.bio ?? ""
        self.bioLinks = []
        self.status = detail.status
        self.statusDescription = detail.statusDescription
        self.tags = detail.tags
    }
}
