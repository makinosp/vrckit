//
//  UserDetailModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/17.
//

import Foundation

public struct UserDetail: ProfileDetailRepresentable, LocationRepresentable {
    public var bio: String?
    public var bioLinks: SafeDecodingArray<URL>
    public let avatarImageUrl: URL?
    public let avatarThumbnailUrl: URL?
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let profilePicOverride: URL?
    public let state: User.State
    public let status: UserStatus
    public var statusDescription: String
    public var tags: UserTags
    public let userIcon: URL?
    public let location: String
    public let friendKey: String
    public let dateJoined: Date?
    public var note: String
    public let lastActivity: Date
    public let platform: UserPlatform
}

public extension UserDetail {
    var url: URL? {
        URL(string: [Const.homeBaseUrl, "user", id].joined(separator: "/"))
    }
}
