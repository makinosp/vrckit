//
//  UserDetailModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

extension UserDetail: ProfileDetailRepresentable, LocationRepresentable {}

public typealias Tag = String

public struct UserDetail: Codable {
    public var bio: String?
    public let bioLinks: [String]?
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

public struct EditableUserInfo: Codable, Hashable {
    public var bio: String
    public var bioLinks: [URL]
    public var status: UserStatus
    public var statusDescription: String
    public var tags: [Tag]

    public init(
        bio: String,
        bioLinks: [URL],
        status: UserStatus,
        statusDescription: String,
        tags: [Tag]
    ) {
        self.bio = bio
        self.bioLinks = bioLinks
        self.status = status
        self.statusDescription = statusDescription
        self.tags = tags
    }

    public init(detail: any ProfileDetailRepresentable) {
        self.bio = detail.bio ?? ""
        // FIXME: [URL]
        self.bioLinks = []
        self.status = detail.status
        self.statusDescription = detail.statusDescription
        self.tags = detail.tags
    }
}
