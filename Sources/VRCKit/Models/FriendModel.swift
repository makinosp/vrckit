//
//  FriendModel.swift
//  VRCKit
//
//  Created by makinosp on 2024/03/03.
//

import Foundation

extension Friend: ProfileElementRepresentable, LocationRepresentable {}

public struct Friend: Codable {
    public let bio: String?
    public let bioLinks: [String]?
    public let currentAvatarImageUrl: String?
    public let currentAvatarThumbnailImageUrl: String?
    public let displayName: String
    public let id: String
    public let isFriend: Bool
    public let lastLogin: Date
    public let lastPlatform: String
    public let profilePicOverride: String?
    public let status: User.Status
    public let statusDescription: String
    public let tags: [String]
    public let userIcon: String?
    public let location: String
    public let friendKey: String
}

extension FriendsLocation: LocationRepresentable {}

public struct FriendsLocation: Identifiable, Hashable {
    public let location: String
    public let friends: [Friend]
    public var id: String { location }
}
